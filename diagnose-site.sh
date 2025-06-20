#!/bin/bash

# Site diagnostic script to check for common issues

echo "🔍 Jekyll Site Diagnostics"
echo "========================="

# Check file structure
echo "📁 Checking file structure..."

# Check layouts
if [ -d "_layouts" ]; then
    echo "✅ _layouts directory exists"
    ls -la _layouts/
else
    echo "❌ _layouts directory missing"
fi

# Check CSS files
if [ -d "assets/css" ]; then
    echo "✅ assets/css directory exists"
    ls -la assets/css/
else
    echo "❌ assets/css directory missing"
fi

# Check posts
if [ -d "_posts" ]; then
    echo "✅ _posts directory exists"
    echo "📝 Post count: $(ls _posts/*.md 2>/dev/null | wc -l)"
else
    echo "❌ _posts directory missing"
fi

# Check configuration
echo ""
echo "⚙️ Checking configuration..."

if [ -f "_config.yml" ]; then
    echo "✅ _config.yml exists"
    
    # Check for important settings
    if grep -q "markdown: kramdown" _config.yml; then
        echo "✅ Kramdown markdown processor configured"
    else
        echo "⚠️  Kramdown not configured"
    fi
    
    if grep -q "highlighter: rouge" _config.yml; then
        echo "✅ Rouge syntax highlighter configured"
    else
        echo "⚠️  Rouge not configured"
    fi
else
    echo "❌ _config.yml missing"
fi

# Check Gemfile
echo ""
echo "💎 Checking Ruby dependencies..."

if [ -f "Gemfile" ]; then
    echo "✅ Gemfile exists"
    
    if grep -q "jekyll" Gemfile; then
        echo "✅ Jekyll dependency found"
    else
        echo "❌ Jekyll dependency missing"
    fi
    
    if grep -q "kramdown-math-katex" Gemfile; then
        echo "✅ Math support (KaTeX) configured"
    else
        echo "⚠️  Math support not configured"
    fi
else
    echo "❌ Gemfile missing"
fi

# Check for common issues
echo ""
echo "🚨 Checking for common issues..."

# Check for Liquid syntax issues
echo "Checking for Liquid syntax issues..."
LIQUID_ISSUES=$(find _posts -name "*.md" -exec grep -l "{{" {} \; 2>/dev/null | wc -l)
if [ $LIQUID_ISSUES -gt 0 ]; then
    echo "⚠️  Found $LIQUID_ISSUES files with potential Liquid syntax issues"
    echo "💡 Run ./fix-liquid-syntax.sh to check details"
else
    echo "✅ No obvious Liquid syntax issues found"
fi

# Check for missing front matter
echo "Checking front matter..."
MISSING_FRONTMATTER=0
for file in _posts/*.md; do
    if [ -f "$file" ]; then
        if ! head -n 1 "$file" | grep -q "^---$"; then
            echo "❌ Missing front matter: $file"
            MISSING_FRONTMATTER=$((MISSING_FRONTMATTER + 1))
        fi
    fi
done

if [ $MISSING_FRONTMATTER -eq 0 ]; then
    echo "✅ All posts have proper front matter"
else
    echo "❌ Found $MISSING_FRONTMATTER posts with missing front matter"
fi

# Check homepage
echo ""
echo "🏠 Checking homepage..."

if [ -f "index.md" ]; then
    echo "✅ index.md exists"
    
    if grep -q "title: Home" index.md; then
        echo "✅ Homepage title configured"
    else
        echo "⚠️  Homepage title not set to 'Home'"
    fi
    
    if grep -q "hacker-homepage" index.md; then
        echo "✅ Hacker homepage styling detected"
    else
        echo "⚠️  Hacker homepage styling not found"
    fi
else
    echo "❌ index.md missing"
fi

# Test local build (if possible)
echo ""
echo "🔨 Testing local build..."

if command -v bundle &> /dev/null; then
    echo "✅ Bundler available"
    
    if [ -f "Gemfile.lock" ]; then
        echo "✅ Dependencies already installed"
    else
        echo "⚠️  Dependencies not installed"
        echo "💡 Run 'bundle install' to install dependencies"
    fi
    
    # Try a dry run build
    echo "Testing Jekyll build..."
    if bundle exec jekyll build --dry-run 2>/dev/null; then
        echo "✅ Jekyll build test passed"
    else
        echo "❌ Jekyll build test failed"
        echo "💡 Run 'bundle exec jekyll build' for detailed error messages"
    fi
else
    echo "❌ Bundler not available"
    echo "💡 Install with: gem install bundler"
fi

# Summary
echo ""
echo "📊 Diagnostic Summary"
echo "===================="

# Count issues
TOTAL_ISSUES=$((MISSING_FRONTMATTER + LIQUID_ISSUES))

if [ $TOTAL_ISSUES -eq 0 ]; then
    echo "🎉 No major issues detected!"
    echo "✅ Your site should be working properly"
else
    echo "⚠️  Found $TOTAL_ISSUES potential issues"
    echo "💡 Review the warnings above and fix as needed"
fi

echo ""
echo "🔗 Useful commands:"
echo "- Test locally: bundle exec jekyll serve"
echo "- Check syntax: ./fix-liquid-syntax.sh"
echo "- Test markdown: ./test-markdown.sh"
echo "- View site: https://baymine.github.io"
echo "- Check build status: https://github.com/Baymine/Baymine.github.io/actions"
