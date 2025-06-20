#!/bin/bash

# Simple script to create a new Jekyll post
# Usage: ./new-post.sh "Your Post Title"

if [ $# -eq 0 ]; then
    echo "Usage: $0 \"Your Post Title\""
    echo "Example: $0 \"My New Blog Post\""
    exit 1
fi

TITLE="$1"
DATE=$(date +"%Y-%m-%d")
TIME=$(date +"%H:%M:%S")
TIMEZONE="+0800"

# Create filename-friendly slug
SLUG=$(echo "$TITLE" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | sed 's/--*/-/g' | sed 's/^-\|-$//g')
FILENAME="${DATE}-${SLUG}.md"
FILEPATH="_posts/${FILENAME}"

# Create the post file
cat > "$FILEPATH" << EOF
---
layout: post
title: "$TITLE"
date: $DATE $TIME $TIMEZONE
categories: [blog]
tags: []
---

# $TITLE

Write your post content here...

## Introduction

Brief introduction to the topic.

## Main Content

Your main content goes here.

## Conclusion

Wrap up your thoughts.

---

*Happy coding!*
EOF

echo "✅ Created new post: $FILEPATH"
echo ""
echo "Next steps:"
echo "1. Edit the file and add your content"
echo "2. Update categories and tags"
echo "3. Commit and push to deploy:"
echo "   git add $FILEPATH"
echo "   git commit -m \"Add new post: $TITLE\""
echo "   git push origin main"
