#!/usr/bin/env python3
"""
Script to fix math equation formatting for KaTeX rendering
"""

import re
from pathlib import Path

def fix_math_in_content(content):
    """Fix math equation formatting in content"""
    
    # Fix standalone math equations (add $$ delimiters)
    # Look for lines that contain LaTeX commands but aren't already in math mode
    lines = content.split('\n')
    fixed_lines = []
    
    for line in lines:
        # Skip if already in math mode
        if '$$' in line or line.strip().startswith('$') and line.strip().endswith('$'):
            fixed_lines.append(line)
            continue
            
        # Check if line contains LaTeX math commands
        latex_patterns = [
            r'\\[a-zA-Z]+\{',  # LaTeX commands like \operatorname{
            r'\\[a-zA-Z]+\[',  # LaTeX commands with brackets
            r'\\[a-zA-Z]+\(',  # LaTeX commands with parentheses
            r'_\{[^}]+\}',     # Subscripts
            r'\^\{[^}]+\}',    # Superscripts
            r'\\frac\{',       # Fractions
            r'\\sum',          # Summations
            r'\\int',          # Integrals
            r'\\prod',         # Products
            r'\\log',          # Logarithms
            r'\\sqrt',         # Square roots
            r'\\begin\{',      # Begin environments
            r'\\end\{',        # End environments
            r'\\left\[',       # Left brackets
            r'\\right\]',      # Right brackets
            r'\\left\(',       # Left parentheses
            r'\\right\)',      # Right parentheses
            r'\\boldsymbol',   # Bold symbols
            r'\\mathbf',       # Math bold
            r'\\alpha',        # Greek letters
            r'\\beta',
            r'\\gamma',
            r'\\delta',
            r'\\epsilon',
            r'\\lambda',
            r'\\mu',
            r'\\sigma',
            r'\\theta',
            r'\\pi',
            r'\\infty',        # Infinity
        ]
        
        # Check if line contains any LaTeX patterns
        has_math = False
        for pattern in latex_patterns:
            if re.search(pattern, line):
                has_math = True
                break
        
        # Also check for simple math patterns
        if not has_math:
            # Check for equations with = signs and mathematical notation
            if re.search(r'[a-zA-Z_]\s*=\s*[^=]', line) and any(char in line for char in ['_', '^', '\\', '{', '}']):
                has_math = True
        
        if has_math and line.strip():
            # Don't add $$ if it's part of a larger text paragraph
            # Only add $$ if the line is primarily mathematical
            math_content = len(re.findall(r'[\\_{}\^]', line))
            text_content = len(re.findall(r'[a-zA-Z\u4e00-\u9fff]', line))
            
            if math_content > 0 and (math_content >= text_content * 0.3 or line.strip().count('=') > 0):
                # This looks like a math equation
                if not line.strip().startswith('$$') and not line.strip().endswith('$$'):
                    fixed_lines.append(f'$${line.strip()}$$')
                else:
                    fixed_lines.append(line)
            else:
                fixed_lines.append(line)
        else:
            fixed_lines.append(line)
    
    return '\n'.join(fixed_lines)

def process_post(filepath):
    """Process a single blog post for math formatting"""
    print(f"Processing math in: {filepath.name}")
    
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()
        
        original_content = content
        content = fix_math_in_content(content)
        
        # Only write if content changed
        if content != original_content:
            with open(filepath, 'w', encoding='utf-8') as f:
                f.write(content)
            print(f"  ✓ Fixed math equations")
        else:
            print(f"  - No math changes needed")
            
    except Exception as e:
        print(f"  ✗ Error processing {filepath.name}: {e}")

def main():
    """Main function"""
    posts_dir = Path('_posts')
    if not posts_dir.exists():
        print("_posts directory not found!")
        return
    
    print("Math Equation Formatter")
    print("=" * 30)
    
    # Process all markdown files
    post_files = list(posts_dir.glob('*.md'))
    print(f"Processing {len(post_files)} blog posts for math equations...")
    
    for post_file in post_files:
        process_post(post_file)
    
    print(f"\n✓ Completed math equation formatting")

if __name__ == "__main__":
    main()
