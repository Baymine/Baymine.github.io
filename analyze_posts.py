#!/usr/bin/env python3
"""
Script to analyze blog posts and categorize formatting issues
"""

import os
import re
from pathlib import Path
from collections import defaultdict

def analyze_post(filepath):
    """Analyze a single post for formatting issues"""
    issues = {
        'math_equations': False,
        'code_blocks': False,
        'toc_markers': False,
        'html_entities': False,
        'image_links': False,
        'line_numbers_in_code': False
    }
    
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()
            
        # Check for math equations (various formats)
        if re.search(r'\\\(.*?\\\)', content) or re.search(r'\\\[.*?\\\]', content, re.DOTALL):
            issues['math_equations'] = True
        if re.search(r'\$\$.*?\$\$', content, re.DOTALL) or re.search(r'\$.*?\$', content):
            issues['math_equations'] = True
        if re.search(r'\\[a-zA-Z]+\{', content):  # LaTeX commands
            issues['math_equations'] = True
            
        # Check for code blocks
        if re.search(r'```', content) or re.search(r'^\s*\d+\s*$', content, re.MULTILINE):
            issues['code_blocks'] = True
            
        # Check for line numbers in code (standalone numbers on lines)
        if re.search(r'^\s*\d+\s*$', content, re.MULTILINE):
            issues['line_numbers_in_code'] = True
            
        # Check for table of contents markers
        if '@[toc]' in content.lower():
            issues['toc_markers'] = True
            
        # Check for HTML entities
        if re.search(r'&[a-zA-Z]+;', content):
            issues['html_entities'] = True
            
        # Check for image links
        if re.search(r'!\[.*?\]\(.*?\)', content) or 'img-blog.csdnimg.cn' in content:
            issues['image_links'] = True
            
    except Exception as e:
        print(f"Error analyzing {filepath}: {e}")
        
    return issues

def main():
    """Main analysis function"""
    posts_dir = Path('_posts')
    if not posts_dir.exists():
        print("_posts directory not found!")
        return
        
    results = {}
    summary = defaultdict(int)
    
    print("Analyzing blog posts for formatting issues...\n")
    
    for post_file in posts_dir.glob('*.md'):
        print(f"Analyzing: {post_file.name}")
        issues = analyze_post(post_file)
        results[post_file.name] = issues
        
        # Count issues
        for issue_type, has_issue in issues.items():
            if has_issue:
                summary[issue_type] += 1
    
    print(f"\n{'='*60}")
    print("ANALYSIS SUMMARY")
    print(f"{'='*60}")
    print(f"Total posts analyzed: {len(results)}")
    print()
    
    for issue_type, count in summary.items():
        print(f"{issue_type.replace('_', ' ').title()}: {count} posts")
    
    print(f"\n{'='*60}")
    print("POSTS WITH ISSUES")
    print(f"{'='*60}")
    
    for post_name, issues in results.items():
        has_issues = any(issues.values())
        if has_issues:
            print(f"\n{post_name}:")
            for issue_type, has_issue in issues.items():
                if has_issue:
                    print(f"  ✗ {issue_type.replace('_', ' ').title()}")
    
    print(f"\n{'='*60}")
    print("POSTS WITHOUT ISSUES")
    print(f"{'='*60}")
    
    clean_posts = []
    for post_name, issues in results.items():
        if not any(issues.values()):
            clean_posts.append(post_name)
    
    if clean_posts:
        for post in clean_posts:
            print(f"  ✓ {post}")
    else:
        print("  No posts are completely clean")

if __name__ == "__main__":
    main()
