#!/bin/bash

# Script to find and fix common Liquid syntax issues in Jekyll posts
# This helps prevent build failures on GitHub Pages

echo "🔍 Checking for Liquid syntax issues in Jekyll posts..."

# Find posts with double curly braces that might cause issues
echo "Checking for double curly braces..."
DOUBLE_BRACES=$(grep -n "{{" _posts/*.md | grep -v "raw\|endraw" | wc -l)

if [ $DOUBLE_BRACES -gt 0 ]; then
    echo "⚠️  Found $DOUBLE_BRACES potential issues with double curly braces:"
    grep -n "{{" _posts/*.md | grep -v "raw\|endraw"
    echo ""
    echo "💡 To fix these, wrap the problematic lines with:"
    echo "   {% raw %}...problematic content...{% endraw %}"
    echo ""
else
    echo "✅ No double curly brace issues found"
fi

# Find posts with single curly braces that might be Liquid variables
echo "Checking for single curly braces..."
SINGLE_BRACES=$(grep -n "{[^{%]" _posts/*.md | grep -v "raw\|endraw" | wc -l)

if [ $SINGLE_BRACES -gt 0 ]; then
    echo "⚠️  Found $SINGLE_BRACES potential issues with single curly braces:"
    grep -n "{[^{%]" _posts/*.md | grep -v "raw\|endraw" | head -10
    echo ""
    echo "💡 Review these manually - they might need {% raw %} tags if they're code snippets"
    echo ""
else
    echo "✅ No single curly brace issues found"
fi

# Find posts with Liquid tags that might not be closed properly
echo "Checking for unclosed Liquid tags..."
UNCLOSED_TAGS=$(grep -n "{%" _posts/*.md | grep -v "raw\|endraw\|comment\|endcomment" | wc -l)

if [ $UNCLOSED_TAGS -gt 0 ]; then
    echo "⚠️  Found $UNCLOSED_TAGS potential unclosed Liquid tags:"
    grep -n "{%" _posts/*.md | grep -v "raw\|endraw\|comment\|endcomment" | head -5
    echo ""
    echo "💡 Review these manually to ensure they're properly closed"
    echo ""
else
    echo "✅ No unclosed Liquid tag issues found"
fi

echo "🎉 Liquid syntax check complete!"
echo ""
echo "If you found issues, you can:"
echo "1. Wrap problematic code with {% raw %}...{% endraw %} tags"
echo "2. Escape special characters in your content"
echo "3. Use backticks for inline code instead of curly braces when possible"
