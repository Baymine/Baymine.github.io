#!/bin/bash

# Script to test markdown features in the hacker-style blog

echo "🧪 Testing Markdown Features"
echo "============================"

# Function to create a test post
create_test_post() {
    local filename="_posts/$(date +%Y-%m-%d)-markdown-test.md"
    
    cat > "$filename" << 'EOF'
---
layout: post
title: "Markdown Test Post"
date: 2024-06-20 16:00:00 +0800
categories: [test]
tags: [markdown, test]
---

# Markdown Test Post

## Code Highlighting Test

### Python
```python
def hello_world():
    print("Hello, World!")
    return True
```

### JavaScript
```javascript
const greet = (name) => {
    console.log(`Hello, ${name}!`);
};
```

### SQL
```sql
SELECT * FROM users WHERE active = true;
```

## Math Test

Inline math: $E = mc^2$

Display math:
$$
\sum_{i=1}^{n} i = \frac{n(n+1)}{2}
$$

## Table Test

| Feature | Status | Notes |
|---------|--------|-------|
| Syntax Highlighting | ✅ | Working |
| Math Rendering | ✅ | KaTeX |
| Tables | ✅ | Styled |

## List Test

- [x] Code blocks
- [x] Math equations
- [x] Tables
- [ ] Comments (future)

## Blockquote Test

> This is a test blockquote to verify styling.

## Link Test

[Back to homepage](/)

---

*Test completed successfully!*
EOF

    echo "✅ Created test post: $filename"
}

# Function to check dependencies
check_dependencies() {
    echo "🔍 Checking dependencies..."
    
    # Check if Jekyll is available
    if command -v jekyll &> /dev/null; then
        echo "✅ Jekyll: $(jekyll --version)"
    else
        echo "❌ Jekyll not found"
        echo "💡 Install with: gem install jekyll"
    fi
    
    # Check if bundle is available
    if command -v bundle &> /dev/null; then
        echo "✅ Bundler: $(bundle --version)"
    else
        echo "❌ Bundler not found"
        echo "💡 Install with: gem install bundler"
    fi
    
    # Check Gemfile
    if [ -f "Gemfile" ]; then
        echo "✅ Gemfile found"
        
        # Check for math support gems
        if grep -q "kramdown-math-katex" Gemfile; then
            echo "✅ Math support (KaTeX) configured"
        else
            echo "⚠️  Math support not configured"
            echo "💡 Add 'gem \"kramdown-math-katex\"' to Gemfile"
        fi
        
        # Check for syntax highlighting
        if grep -q "rouge" Gemfile; then
            echo "✅ Syntax highlighting (Rouge) configured"
        else
            echo "⚠️  Syntax highlighting not configured"
            echo "💡 Add 'gem \"rouge\"' to Gemfile"
        fi
    else
        echo "❌ Gemfile not found"
    fi
    
    # Check _config.yml
    if [ -f "_config.yml" ]; then
        echo "✅ Jekyll config found"
        
        if grep -q "kramdown" _config.yml; then
            echo "✅ Kramdown markdown processor configured"
        else
            echo "⚠️  Kramdown not configured"
        fi
        
        if grep -q "math_engine: katex" _config.yml; then
            echo "✅ KaTeX math engine configured"
        else
            echo "⚠️  KaTeX math engine not configured"
        fi
    else
        echo "❌ _config.yml not found"
    fi
}

# Function to test local server
test_server() {
    echo "🚀 Testing local server..."
    
    if [ ! -f "Gemfile" ]; then
        echo "❌ No Gemfile found. Cannot test server."
        return 1
    fi
    
    echo "📦 Installing dependencies..."
    if bundle install; then
        echo "✅ Dependencies installed"
    else
        echo "❌ Failed to install dependencies"
        return 1
    fi
    
    echo "🌐 Starting Jekyll server..."
    echo "💡 Server will start at http://localhost:4000"
    echo "💡 Press Ctrl+C to stop the server"
    echo "💡 Test the markdown features in your browser"
    
    bundle exec jekyll serve --drafts
}

# Function to validate markdown files
validate_markdown() {
    echo "📝 Validating markdown files..."
    
    local post_count=0
    local error_count=0
    
    for file in _posts/*.md; do
        if [ -f "$file" ]; then
            post_count=$((post_count + 1))
            echo "Checking: $file"
            
            # Check front matter
            if ! head -n 1 "$file" | grep -q "^---$"; then
                echo "❌ Missing front matter in $file"
                error_count=$((error_count + 1))
            fi
            
            # Check for liquid syntax issues
            if grep -q "{{" "$file" && ! grep -q "{% raw %}" "$file"; then
                echo "⚠️  Potential Liquid syntax issue in $file"
                echo "💡 Consider wrapping with {% raw %}...{% endraw %}"
            fi
        fi
    done
    
    echo "📊 Validation complete:"
    echo "   Posts checked: $post_count"
    echo "   Errors found: $error_count"
    
    if [ $error_count -eq 0 ]; then
        echo "✅ All posts validated successfully!"
    else
        echo "❌ Found $error_count issues"
    fi
}

# Main menu
echo ""
echo "What would you like to test?"
echo "1. Check dependencies"
echo "2. Create test post"
echo "3. Validate existing posts"
echo "4. Start local server"
echo "5. Run all tests"
echo "6. Exit"

read -p "Enter your choice (1-6): " choice

case $choice in
    1)
        check_dependencies
        ;;
    2)
        create_test_post
        ;;
    3)
        validate_markdown
        ;;
    4)
        test_server
        ;;
    5)
        echo "🔄 Running all tests..."
        check_dependencies
        echo ""
        validate_markdown
        echo ""
        create_test_post
        echo ""
        echo "🎉 All tests completed!"
        echo "💡 Run 'bundle exec jekyll serve' to test locally"
        ;;
    6)
        echo "👋 Goodbye!"
        exit 0
        ;;
    *)
        echo "❌ Invalid choice"
        ;;
esac

echo ""
echo "🎯 Quick Tips:"
echo "- Use 'bundle exec jekyll serve' for local testing"
echo "- Math: Use \$ for inline, \$\$ for display"
echo "- Code: Use \`\`\`language for syntax highlighting"
echo "- Check ./fix-liquid-syntax.sh for Liquid issues"
