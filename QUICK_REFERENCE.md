# Jekyll Blog Quick Reference

## Creating New Posts

### Using the script (recommended)
```bash
./new-post.sh "Your Post Title"
```

### Manual creation
1. Create file: `_posts/YYYY-MM-DD-title.md`
2. Add front matter and content

## Front Matter Template

```yaml
---
layout: post
title: "Your Post Title"
date: 2024-06-20 12:00:00 +0800
categories: [category1, category2]
tags: [tag1, tag2, tag3]
---
```

## Deployment

### GitHub Pages (Automatic)
```bash
git add .
git commit -m "Your commit message"
git push origin main
```
Site will be live at https://baymine.github.io within minutes!

### Local Development (Optional)
```bash
bundle exec jekyll serve
# Visit http://localhost:4000
```

## Directory Structure

```
_posts/          # Your blog posts
_pages/          # Static pages (about, etc.)
_drafts/         # Draft posts (not published)
assets/          # Images, CSS, JS
images/          # Legacy images (migrated)
_config.yml      # Site configuration
```

## Markdown Tips

### Headers
```markdown
# H1
## H2
### H3
```

### Code Blocks
```markdown
```python
def hello():
    print("Hello World")
```
```

### Images
```markdown
![Alt text](/assets/images/image.jpg)
```

### Links
```markdown
[Link text](https://example.com)
```

### Lists
```markdown
- Unordered item
- Another item

1. Ordered item
2. Another item
```

## Common Tasks

### Add a new page
1. Create `_pages/pagename.md`
2. Add front matter with `layout: page`
3. Update navigation if needed

### Add images
1. Put images in `assets/images/`
2. Reference as `/assets/images/filename.jpg`

### Update site info
Edit `_config.yml` for site title, description, etc.

## Troubleshooting

### Post not showing
- Check filename format: `YYYY-MM-DD-title.md`
- Verify front matter syntax
- Ensure date is not in the future

### Images not loading
- Check file path and spelling
- Ensure images are in `assets/images/`
- Use forward slashes in paths

### Site not updating
- Wait a few minutes for GitHub Pages to build
- Check repository Actions tab for build status
- Verify you pushed to the `main` branch

## Useful Links

- [Jekyll Documentation](https://jekyllrb.com/docs/)
- [Markdown Guide](https://www.markdownguide.org/)
- [GitHub Pages Documentation](https://docs.github.com/en/pages)
- [Minima Theme](https://github.com/jekyll/minima)
