#!/usr/bin/env ruby

require 'nokogiri'
require 'date'
require 'fileutils'

class JekyllMigrator
  def initialize
    @posts_dir = '_posts'
    @images_dir = 'assets/images'
    
    # Create directories if they don't exist
    FileUtils.mkdir_p(@posts_dir)
    FileUtils.mkdir_p(@images_dir)
  end

  def migrate_all
    puts "🔄 Starting Jekyll migration..."
    
    # Find all HTML files in year/month/day structure
    Dir.glob('*').select { |f| File.directory?(f) && f.match(/^\d{4}$/) }.each do |year|
      Dir.glob("#{year}/*").select { |f| File.directory?(f) && File.basename(f).match(/^\d{2}$/) }.each do |month|
        Dir.glob("#{month}/*").select { |f| File.directory?(f) && File.basename(f).match(/^\d{2}$/) }.each do |day|
          Dir.glob("#{day}/*").select { |f| File.directory?(f) }.each do |post_dir|
            index_file = File.join(post_dir, 'index.html')
            if File.exist?(index_file)
              migrate_post(index_file, year, month, day)
            end
          end
        end
      end
    end
    
    puts "\n🎉 Migration complete!"
    puts "📝 Check the _posts directory for your migrated posts"
    puts "🖼️  Images have been copied to assets/images/"
    puts "\nNext steps:"
    puts "1. Review and edit the generated markdown files"
    puts "2. Update categories and tags as needed"
    puts "3. Test with: bundle exec jekyll serve"
  end

  private

  def migrate_post(html_file, year, month, day)
    puts "Processing: #{html_file}"
    
    begin
      content = File.read(html_file)
      doc = Nokogiri::HTML(content)
      
      # Extract metadata
      title = extract_title(doc)
      date = extract_date(doc, year, month, day)
      
      # Extract main content
      main_content = extract_content(doc)
      
      return if main_content.nil? || main_content.strip.empty?
      
      # Convert to markdown
      markdown_content = html_to_markdown(main_content)
      
      # Generate filename
      filename = generate_filename(title, date)
      
      # Create Jekyll post
      create_jekyll_post(filename, title, date, markdown_content)
      
      puts "✅ Created: #{filename}"
      
    rescue => e
      puts "❌ Error processing #{html_file}: #{e.message}"
    end
  end

  def extract_title(doc)
    # Try different selectors for title
    title = doc.css('h1.title').first&.text ||
            doc.css('title').first&.text ||
            doc.css('h1').first&.text ||
            'Untitled Post'
    
    # Clean up title
    title.gsub(/\s*-\s*Baymine's Blog\s*$/, '').strip
  end

  def extract_date(doc, year, month, day)
    # Try to extract from meta tags first
    published_time = doc.css('meta[property="article:published_time"]').first&.[]('content')
    
    if published_time
      DateTime.parse(published_time)
    else
      # Use directory structure
      DateTime.new(year.to_i, month.to_i, day.to_i, 12, 0, 0, '+08:00')
    end
  end

  def extract_content(doc)
    # Try different selectors for main content
    content_element = doc.css('.content').first ||
                     doc.css('article').first ||
                     doc.css('.post-content').first ||
                     doc.css('main').first ||
                     doc.css('.card-content .content').first
    
    return nil unless content_element
    
    content_element.inner_html
  end

  def html_to_markdown(html)
    # Basic HTML to Markdown conversion
    markdown = html.dup
    
    # Headers
    markdown.gsub!(/<h([1-6])[^>]*>(.*?)<\/h\1>/mi) { |match| "#{'#' * $1.to_i} #{$2.strip}" }
    
    # Bold and italic
    markdown.gsub!(/<(strong|b)[^>]*>(.*?)<\/\1>/mi, '**\2**')
    markdown.gsub!(/<(em|i)[^>]*>(.*?)<\/\1>/mi, '*\2*')
    
    # Code blocks
    markdown.gsub!(/<pre[^>]*><code[^>]*>(.*?)<\/code><\/pre>/mi) { |match| "```\n#{$1.strip}\n```" }
    markdown.gsub!(/<code[^>]*>(.*?)<\/code>/mi, '`\1`')
    
    # Links
    markdown.gsub!(/<a[^>]*href="([^"]*)"[^>]*>(.*?)<\/a>/mi, '[\2](\1)')
    
    # Images
    markdown.gsub!(/<img[^>]*src="([^"]*)"[^>]*alt="([^"]*)"[^>]*>/mi, '![\2](\1)')
    markdown.gsub!(/<img[^>]*src="([^"]*)"[^>]*>/mi, '![](\1)')
    
    # Lists
    markdown.gsub!(/<ul[^>]*>(.*?)<\/ul>/mi) do |match|
      list_content = $1
      list_content.gsub!(/<li[^>]*>(.*?)<\/li>/mi, '- \1')
      list_content
    end
    
    markdown.gsub!(/<ol[^>]*>(.*?)<\/ol>/mi) do |match|
      list_content = $1
      counter = 1
      list_content.gsub!(/<li[^>]*>(.*?)<\/li>/mi) { "#{counter}. #{$1}"; counter += 1; }
      list_content
    end
    
    # Blockquotes
    markdown.gsub!(/<blockquote[^>]*>(.*?)<\/blockquote>/mi, '> \1')
    
    # Paragraphs
    markdown.gsub!(/<p[^>]*>(.*?)<\/p>/mi, "\n\n\\1\n\n")
    
    # Line breaks
    markdown.gsub!(/<br[^>]*>/mi, "\n")
    
    # Remove remaining HTML tags
    markdown.gsub!(/<[^>]*>/, '')
    
    # Clean up whitespace
    markdown.gsub!(/\n\s*\n\s*\n/, "\n\n")
    markdown.strip
  end

  def generate_filename(title, date)
    # Create Jekyll-style filename
    slug = title.downcase
                .gsub(/[^\w\s-]/, '')
                .gsub(/\s+/, '-')
                .gsub(/-+/, '-')
                .strip
    
    "#{date.strftime('%Y-%m-%d')}-#{slug}.md"
  end

  def create_jekyll_post(filename, title, date, content)
    front_matter = <<~YAML
      ---
      layout: post
      title: "#{title.gsub('"', '\"')}"
      date: #{date.strftime('%Y-%m-%d %H:%M:%S %z')}
      categories: [blog]
      tags: []
      ---

    YAML
    
    File.write(File.join(@posts_dir, filename), front_matter + content)
  end
end

# Run migration if script is called directly
if __FILE__ == $0
  migrator = JekyllMigrator.new
  migrator.migrate_all
end
