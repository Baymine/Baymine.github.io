#!/usr/bin/env python3
"""
Script to automatically fix common formatting issues in blog posts
"""

import re
import shutil
from pathlib import Path

def backup_posts():
    """Create backup of all posts before making changes"""
    backup_dir = Path('_posts_backup')
    posts_dir = Path('_posts')
    
    if backup_dir.exists():
        shutil.rmtree(backup_dir)
    
    shutil.copytree(posts_dir, backup_dir)
    print(f"✓ Created backup in {backup_dir}")

def fix_html_entities(content):
    """Fix HTML entities"""
    replacements = {
        '&gt;': '>',
        '&lt;': '<',
        '&amp;': '&',
        '&quot;': '"',
        '&apos;': "'",
        '&nbsp;': ' '
    }
    
    for entity, char in replacements.items():
        content = content.replace(entity, char)
    
    return content

def fix_table_of_contents(content):
    """Remove or replace table of contents markers"""
    # Remove @[toc] markers
    content = re.sub(r'@\[toc\]', '', content, flags=re.IGNORECASE)
    return content

def fix_math_equations(content):
    """Fix math equation delimiters for KaTeX"""
    # Convert \( ... \) to $ ... $ for inline math
    content = re.sub(r'\\\((.*?)\\\)', r'$\1$', content, flags=re.DOTALL)
    
    # Convert \[ ... \] to $$ ... $$ for display math
    content = re.sub(r'\\\[(.*?)\\\]', r'$$\1$$', content, flags=re.DOTALL)
    
    # Ensure display math equations are on separate lines
    content = re.sub(r'([^\n])\$\$', r'\1\n$$', content)
    content = re.sub(r'\$\$([^\n])', r'$$\n\1', content)
    
    return content

def fix_code_blocks(content):
    """Clean up code blocks and remove line numbers"""
    # Simple approach: remove standalone line numbers
    lines = content.split('\n')
    fixed_lines = []

    for i, line in enumerate(lines):
        # Skip lines that are just numbers (likely line numbers)
        if re.match(r'^\s*\d+\s*$', line):
            # Check if this looks like a line number by looking at context
            prev_line = lines[i-1] if i > 0 else ""
            next_line = lines[i+1] if i < len(lines)-1 else ""

            # Skip if it looks like a line number in code context
            if (prev_line.strip() and not prev_line.strip().startswith('#') and
                next_line.strip() and not next_line.strip().startswith('#')):
                continue

        fixed_lines.append(line)

    return '\n'.join(fixed_lines)



def fix_image_links(content):
    """Fix image links - remove broken CSDN links or replace with placeholders"""
    # Remove CSDN image links that are likely broken
    content = re.sub(r'!\[.*?\]\(https://img-blog\.csdnimg\.cn/.*?\)',
                    '<!-- Image removed: CSDN link no longer accessible -->', content)

    return content

def process_post(filepath):
    """Process a single blog post"""
    print(f"Processing: {filepath.name}")

    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()

        original_content = content

        # Apply all fixes
        content = fix_html_entities(content)
        content = fix_table_of_contents(content)
        content = fix_math_equations(content)
        content = fix_code_blocks(content)
        content = fix_image_links(content)

        # Only write if content changed
        if content != original_content:
            with open(filepath, 'w', encoding='utf-8') as f:
                f.write(content)
            print(f"  ✓ Fixed formatting issues")
        else:
            print(f"  - No changes needed")

    except Exception as e:
        print(f"  ✗ Error processing {filepath.name}: {e}")

def main():
    """Main function"""
    posts_dir = Path('_posts')
    if not posts_dir.exists():
        print("_posts directory not found!")
        return

    print("Blog Post Formatting Fixer")
    print("=" * 50)

    # Create backup
    backup_posts()

    # Process all markdown files
    post_files = list(posts_dir.glob('*.md'))
    print(f"\nProcessing {len(post_files)} blog posts...")

    for post_file in post_files:
        process_post(post_file)

    print(f"\n✓ Completed processing all posts")
    print(f"✓ Backup created in _posts_backup/")
    print(f"\nNext steps:")
    print(f"1. Review the changes")
    print(f"2. Test the site locally")
    print(f"3. Commit and push if satisfied")

if __name__ == "__main__":
    main()
