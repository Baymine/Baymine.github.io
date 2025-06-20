# Baymine's Blog

This repository contains the Jekyll source files for Baymine's GitHub blog (https://baymine.github.io).

## Overview

Your blog is now built with **Jekyll**, which is natively supported by GitHub Pages. This makes deployment much simpler - just push your changes and GitHub Pages will automatically build and deploy your site!

## Jekyll Setup

Your blog now uses:
- **Jekyll** static site generator
- **Custom hacker-style homepage** with terminal aesthetics
- **Minima theme** for blog posts (clean and responsive)
- **GitHub Pages** native support (no build process needed)
- **Markdown** for writing posts
- **Automatic deployment** when you push changes

## Quick Start

This repository now contains a complete Jekyll setup! You can start publishing immediately:

```bash
# Install dependencies (first time only)
bundle install

# Create a new post
bundle exec jekyll post "Your Post Title"

# Preview locally
bundle exec jekyll serve

# Deploy (just push to GitHub!)
git add .
git commit -m "Add new post"
git push origin main
```

## Repository Structure

```
├── _posts/             # Blog posts (Markdown files)
├── _pages/             # Static pages
├── _layouts/           # Custom layouts
├── _includes/          # Reusable components
├── assets/             # Images, CSS, JS files
│   ├── css/            # Custom stylesheets
│   └── js/             # JavaScript files
├── _config.yml         # Jekyll configuration
├── Gemfile             # Ruby dependencies
├── index.md            # Hacker-style homepage
├── 404.html            # Custom 404 page
├── migrate.rb          # Migration script
├── customize-theme.sh  # Theme customization tool
└── README.md           # This file
```

## Setup Options

You have two options to work with this Jekyll blog:

### Option 1: Direct GitHub Pages Deployment (Recommended)

**No local setup required!** Just push your changes and GitHub Pages will build automatically.

1. **Enable GitHub Pages**
   - Go to your repository settings on GitHub
   - Under "Pages", select "Deploy from a branch"
   - Choose "main" branch and "/ (root)" folder
   - GitHub will automatically build and deploy your Jekyll site!

2. **Start writing posts**
   - Create new `.md` files in the `_posts/` directory
   - Follow the naming convention: `YYYY-MM-DD-title.md`
   - Add front matter and content (see examples below)

3. **Push and deploy**
   ```bash
   git add .
   git commit -m "Add new post"
   git push origin main
   ```
   Your site will be live at `https://baymine.github.io` within minutes!

### Option 2: Local Development Setup

For local preview and development:

1. **Install Ruby and Bundler** (Ruby 3.0+ recommended)
   ```bash
   # On macOS with Homebrew
   brew install ruby
   gem install bundler

   # On Ubuntu/Debian
   sudo apt-get install ruby-full build-essential zlib1g-dev
   gem install bundler

   # On Windows
   # Download and install Ruby from https://rubyinstaller.org/
   ```

2. **Install dependencies**
   ```bash
   bundle install
   ```

3. **Test the setup**
   ```bash
   bundle exec jekyll serve
   # Visit http://localhost:4000
   ```

### Deployment

Jekyll deployment is automatic with GitHub Pages! No complex setup needed:

1. **Just push your changes**
   ```bash
   git add .
   git commit -m "Add new post"
   git push origin main
   ```

2. **GitHub automatically builds and deploys**
   - GitHub Pages detects Jekyll and builds your site automatically
   - No GitHub Actions or complex workflows needed
   - Your site will be live at `https://baymine.github.io` within minutes

## 🎨 Hacker-Style Homepage

Your blog features a custom cyberpunk-inspired homepage with:

### ✨ Visual Features
- **Terminal-style interface** with realistic command prompts
- **Matrix rain background** effect (animated falling characters)
- **ASCII art banner** with your name
- **Glowing green text** with cyberpunk aesthetics
- **Animated typing effects** for commands
- **Interactive elements** with hover effects

### 🎮 Interactive Elements
- **Skill tags** that respond to clicks
- **Navigation links** with terminal-style formatting
- **Konami code easter egg** (try: ↑↑↓↓←→←→BA)
- **Random glitch effects** on hover
- **Blinking cursor** animation

### 🛠️ Customization
```bash
# Customize colors, effects, and more
./customize-theme.sh
```

### 🎯 Theme Features
- **Responsive design** - works on all devices
- **Performance optimized** - lightweight animations
- **Accessibility friendly** - readable and navigable
- **SEO optimized** - proper meta tags and structure

## 📝 Enhanced Markdown Support

Your blog now has professional-grade markdown support with:

### ✨ Syntax Highlighting
- **100+ programming languages** supported
- **Line numbers** for better readability
- **Copy-to-clipboard** functionality
- **Hacker-themed** color scheme

```python
# Example: Python code with syntax highlighting
def fibonacci(n):
    if n <= 1:
        return n
    return fibonacci(n-1) + fibonacci(n-2)
```

### 🧮 Mathematics Support
- **Inline math**: Use `$equation$` for inline equations
- **Display math**: Use `$$equation$$` for centered equations
- **KaTeX rendering** for fast, beautiful math

Example: $E = mc^2$ and $$\sum_{i=1}^{n} i = \frac{n(n+1)}{2}$$

### 📊 Enhanced Tables
- **Styled tables** with hacker theme
- **Responsive design** for mobile
- **Sortable columns** (optional)

### ✅ Task Lists
- [x] Syntax highlighting
- [x] Math support
- [x] Hacker styling
- [ ] Comments system

### 🎨 Consistent Styling
- **All blog posts** use the hacker terminal theme
- **Static pages** (like About) match the homepage
- **Responsive design** across all content types
- **Terminal aesthetics** throughout the site

### 🛠️ Testing Tools
```bash
# Test markdown features
./test-markdown.sh

# Check for syntax issues
./fix-liquid-syntax.sh
```

## 📚 Blog Navigation & Archives

Your blog now has comprehensive navigation to access all historical content:

### 🗂️ **Archive Pages**
- **[Archives](/archives/)** - Complete chronological list of all posts
- **[Categories](/categories/)** - Posts organized by topic categories
- **[Tags](/tags/)** - Posts grouped by technology tags with tag cloud
- **[Search](/search/)** - Real-time search across all content

### 🧭 **Navigation Features**
- **Homepage links** to all archive pages
- **Post navigation** with previous/next post links
- **Quick access** to archives from any blog post
- **Post count display** showing total number of articles
- **"View All Posts"** link prominently displayed on homepage

### 🔍 **Search Functionality**
- **Real-time search** as you type
- **Searches across** titles, content, categories, and tags
- **Responsive results** with post excerpts
- **Terminal-style interface** matching the hacker theme

### 📊 **Archive Organization**
- **By Year**: Posts grouped chronologically
- **By Category**: Content organized by broad topics
- **By Tag**: Specific technology and keyword groupings
- **Complete List**: All posts in reverse chronological order

## Migrating Existing Posts

If you have existing posts in HTML format (like in this repository), you can migrate them to Jekyll:

1. **Run the migration script**
   ```bash
   ruby migrate.rb
   ```

2. **Review the generated posts**
   - Check `_posts/` for the converted markdown files
   - Update categories and tags as needed
   - Fix any formatting issues

3. **Test the migration**
   ```bash
   bundle exec jekyll serve
   ```

The migration script will:
- Extract content from existing HTML files
- Convert HTML to Markdown format
- Generate proper Jekyll front matter
- Preserve post dates and titles
- Copy images to the assets directory

## Publishing Workflow

### Creating a New Post

1. **Create a new post file**
   ```bash
   # Create file manually in _posts/ directory
   # Format: YYYY-MM-DD-title.md
   touch _posts/2024-06-20-my-new-post.md
   ```

2. **Add front matter and content**
   ```markdown
   ---
   layout: post
   title: "My New Post"
   date: 2024-06-20 12:00:00 +0800
   categories: [blog, technology]
   tags: [jekyll, github-pages]
   ---

   Your post content here...
   ```

3. **Preview locally**
   ```bash
   bundle exec jekyll serve
   ```
   Visit `http://localhost:4000` to preview

4. **Publish**
   ```bash
   git add .
   git commit -m "Add new post: My New Post"
   git push origin main
   ```

   GitHub Pages will automatically build and deploy your site!

### Working with Drafts

```bash
# Create a draft in _drafts/ directory
mkdir -p _drafts
touch _drafts/my-draft-post.md

# Preview drafts locally (only works with local setup)
bundle exec jekyll serve --drafts

# When ready, move to _posts/ with proper filename
mv _drafts/my-draft-post.md _posts/2024-06-20-my-draft-post.md
```

## Post Examples

### Basic Post Template

```markdown
---
layout: post
title: "Your Post Title"
date: 2024-06-20 12:00:00 +0800
categories: [technology, programming]
tags: [jekyll, github-pages, blog]
---

# Your Post Title

Your content goes here...

## Code Examples

```python
def hello_world():
    print("Hello, World!")
```

## Lists

- Item 1
- Item 2
- Item 3

## Links and Images

[Link to GitHub](https://github.com)

![Image description](/assets/images/your-image.jpg)
```

### Categories and Tags

- **Categories**: Broad topics (e.g., technology, programming, personal)
- **Tags**: Specific keywords (e.g., python, database, tutorial)

### Migrated Posts

Your existing posts have been migrated and are available in the `_posts/` directory. You may want to:

1. Review the converted markdown for formatting issues
2. Add appropriate categories and tags
3. Update any broken links or images
4. Add better titles where needed (some have empty titles due to encoding issues)

## Post Structure

### Front Matter Example
```yaml
---
title: "Your Post Title"
date: 2024-06-20 10:00:00
updated: 2024-06-20 10:00:00
tags:
  - tag1
  - tag2
categories:
  - category1
---
```

### Content Guidelines
- Use Markdown syntax for formatting
- Add images to `source/images/` directory
- Reference images with: `![alt text](/images/image-name.jpg)`
- Use code blocks with syntax highlighting:
  ```javascript
  console.log("Hello World");
  ```

## Configuration Files

### Key Hexo Configuration (_config.yml)
```yaml
# Site
title: Baymine's Blog
subtitle: ''
description: ''
keywords:
author: York Cao
language: en
timezone: ''

# URL
url: https://baymine.github.io
root: /

# Theme
theme: icarus

# Deployment
deploy:
  type: git
  repo: https://github.com/Baymine/Baymine.github.io.git
  branch: main
```

## Troubleshooting

### Common Issues

1. **Build fails with Liquid syntax error**
   - Run `./fix-liquid-syntax.sh` to check for issues
   - Wrap problematic code with `{% raw %}...{% endraw %}` tags
   - Common culprits: `{{}}`, `{%`, template-like syntax in code

2. **Posts not showing**
   - Check filename format: `YYYY-MM-DD-title.md`
   - Verify front matter syntax
   - Ensure date is not in the future

3. **Images not loading**
   - Check file paths and spelling
   - Use `/assets/images/filename.jpg` format
   - Ensure images are in the correct directory

4. **Site not updating**
   - Wait a few minutes for GitHub Pages to build
   - Check repository Actions tab for build status
   - Verify you pushed to the `main` branch

### Useful Commands
```bash
# Create new post
./new-post.sh "Post Title"

# Check for Liquid syntax issues
./fix-liquid-syntax.sh

# Local development (if Ruby is set up)
bundle exec jekyll serve

# Deploy
git add . && git commit -m "Update" && git push origin main
```

## Next Steps

1. **Locate or recreate your Hexo source repository**
2. **Set up proper deployment workflow**
3. **Create your first new post using this guide**
4. **Consider setting up automated deployment with GitHub Actions**

## Automated Deployment with GitHub Actions

For a more streamlined workflow, consider setting up GitHub Actions:

### Example GitHub Actions Workflow
Create `.github/workflows/deploy.yml` in your source repository:

```yaml
name: Deploy Blog

on:
  push:
    branches: [ main ]

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v2
      with:
        submodules: true

    - name: Setup Node.js
      uses: actions/setup-node@v2
      with:
        node-version: '16'

    - name: Install dependencies
      run: npm install

    - name: Generate static files
      run: |
        hexo clean
        hexo generate

    - name: Deploy to GitHub Pages
      uses: peaceiris/actions-gh-pages@v3
      with:
        github_token: ${{ secrets.GITHUB_TOKEN }}
        publish_dir: ./public
        publish_branch: main
        external_repository: Baymine/Baymine.github.io
```

## Content Management Tips

### Organizing Posts
- Use consistent naming conventions for files
- Group related posts with similar tags
- Consider creating series of posts on complex topics
- Use categories to organize content by subject area

### SEO Best Practices
- Write descriptive titles and meta descriptions
- Use relevant tags and categories
- Include alt text for images
- Create internal links between related posts
- Optimize images for web (compress file sizes)

### Writing Tips
- Start with an outline
- Use headers to structure content
- Include code examples when relevant
- Add images to break up text
- Proofread before publishing

## Backup and Version Control

### Recommended Setup
1. **Source repository**: Contains Hexo source files (private)
2. **Generated repository**: Contains static files (public - this repo)
3. **Regular backups**: Keep source files backed up

### Git Workflow
```bash
# In your source repository
git add .
git commit -m "Add new post: Your Post Title"
git push origin main

# This triggers deployment to Baymine.github.io
```

## Additional Resources

- [Hexo Documentation](https://hexo.io/docs/)
- [Icarus Theme Documentation](https://github.com/ppoffice/hexo-theme-icarus)
- [Markdown Guide](https://www.markdownguide.org/)
- [GitHub Pages Documentation](https://docs.github.com/en/pages)
- [GitHub Actions for Hexo](https://hexo.io/docs/github-pages)
