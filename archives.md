---
layout: page
title: Archives
permalink: /archives/
---

# Blog Archives

Welcome to the complete archive of all blog posts. Browse by year, category, or search through all content.

## Posts by Year

{% assign posts_by_year = site.posts | group_by_exp: "post", "post.date | date: '%Y'" %}
{% for year in posts_by_year %}

### {{ year.name }}
<div class="year-posts">
{% for post in year.items %}
  <div class="archive-post">
    <span class="post-date">{{ post.date | date: "%m-%d" }}</span>
    <a href="{{ post.url }}" class="post-title">{{ post.title | default: "Untitled" }}</a>
    {% if post.categories and post.categories.size > 0 %}
    <span class="post-categories">
      {% for category in post.categories %}
        <span class="category-tag">{{ category }}</span>
      {% endfor %}
    </span>
    {% endif %}
  </div>
{% endfor %}
</div>

{% endfor %}

## Posts by Category

{% assign posts_by_category = site.posts | group_by: "categories" %}
{% for category in posts_by_category %}
{% unless category.name == "" %}

### {{ category.name | join: ", " | capitalize }}
<div class="category-posts">
{% for post in category.items %}
  <div class="archive-post">
    <span class="post-date">{{ post.date | date: "%Y-%m-%d" }}</span>
    <a href="{{ post.url }}" class="post-title">{{ post.title | default: "Untitled" }}</a>
  </div>
{% endfor %}
</div>

{% endunless %}
{% endfor %}

## All Posts ({{ site.posts.size }} total)

<div class="all-posts">
{% for post in site.posts %}
  <div class="archive-post">
    <span class="post-date">{{ post.date | date: "%Y-%m-%d" }}</span>
    <a href="{{ post.url }}" class="post-title">{{ post.title | default: "Untitled" }}</a>
    {% if post.tags and post.tags.size > 0 %}
    <span class="post-tags">
      {% for tag in post.tags limit:3 %}
        <span class="tag">{{ tag }}</span>
      {% endfor %}
    </span>
    {% endif %}
  </div>
{% endfor %}
</div>

<style>
/* Archive page specific styles */
.year-posts, .category-posts, .all-posts {
  margin: 20px 0;
  padding: 15px;
  border: 1px solid var(--text-darker, #008f11);
  border-radius: 6px;
  background: rgba(0, 255, 65, 0.02);
}

.archive-post {
  display: flex;
  align-items: center;
  padding: 8px 0;
  border-bottom: 1px solid rgba(0, 255, 65, 0.1);
  flex-wrap: wrap;
  gap: 10px;
}

.archive-post:last-child {
  border-bottom: none;
}

.archive-post:hover {
  background: rgba(0, 255, 65, 0.05);
  padding-left: 10px;
  transition: all 0.3s ease;
}

.post-date {
  color: var(--text-darker, #008f11);
  font-size: 12px;
  font-family: 'Fira Code', monospace;
  min-width: 80px;
  flex-shrink: 0;
}

.post-title {
  color: var(--text-green, #00ff41);
  text-decoration: none;
  font-weight: 500;
  flex: 1;
  min-width: 200px;
}

.post-title:hover {
  color: var(--primary-green, #00ff41);
  text-shadow: 0 0 10px rgba(0, 255, 65, 0.5);
}

.post-categories, .post-tags {
  display: flex;
  gap: 5px;
  flex-wrap: wrap;
}

.category-tag, .tag {
  background: rgba(0, 255, 65, 0.1);
  border: 1px solid var(--text-darker, #008f11);
  color: var(--text-green, #00cc33);
  padding: 2px 6px;
  border-radius: 3px;
  font-size: 10px;
  font-weight: 500;
}

.category-tag:hover, .tag:hover {
  background: rgba(0, 255, 65, 0.2);
  border-color: var(--primary-green, #00ff41);
}

/* Responsive design */
@media (max-width: 768px) {
  .archive-post {
    flex-direction: column;
    align-items: flex-start;
  }
  
  .post-date {
    min-width: auto;
  }
  
  .post-title {
    min-width: auto;
    width: 100%;
  }
}
</style>
