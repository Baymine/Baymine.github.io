---
layout: page
title: Categories
permalink: /categories/
---

# Categories

Browse posts by category to find content on specific topics.

{% assign categories = site.categories | sort %}
{% for category in categories %}

## {{ category[0] | capitalize }}

<div class="category-section">
  <div class="category-info">
    <span class="post-count">{{ category[1].size }} posts</span>
  </div>
  
  <div class="category-posts">
    {% for post in category[1] %}
    <div class="category-post">
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
</div>

{% endfor %}

<style>
/* Category page specific styles */
.category-section {
  margin: 30px 0;
  padding: 20px;
  border: 1px solid var(--text-darker, #008f11);
  border-radius: 6px;
  background: rgba(0, 255, 65, 0.02);
}

.category-info {
  margin-bottom: 15px;
  padding-bottom: 10px;
  border-bottom: 1px solid rgba(0, 255, 65, 0.2);
}

.post-count {
  color: var(--text-dim, #00cc33);
  font-size: 14px;
  font-weight: 500;
}

.category-posts {
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.category-post {
  display: flex;
  align-items: center;
  padding: 10px;
  border: 1px solid rgba(0, 255, 65, 0.1);
  border-radius: 4px;
  background: rgba(0, 255, 65, 0.01);
  transition: all 0.3s ease;
  flex-wrap: wrap;
  gap: 10px;
}

.category-post:hover {
  background: rgba(0, 255, 65, 0.05);
  border-color: var(--text-darker, #008f11);
  transform: translateX(5px);
}

.category-post .post-date {
  color: var(--text-darker, #008f11);
  font-size: 12px;
  font-family: 'Fira Code', monospace;
  min-width: 100px;
  flex-shrink: 0;
}

.category-post .post-title {
  color: var(--text-green, #00ff41);
  text-decoration: none;
  font-weight: 500;
  flex: 1;
  min-width: 200px;
}

.category-post .post-title:hover {
  color: var(--primary-green, #00ff41);
  text-shadow: 0 0 10px rgba(0, 255, 65, 0.5);
}

.category-post .post-tags {
  display: flex;
  gap: 5px;
  flex-wrap: wrap;
}

.category-post .tag {
  background: rgba(0, 255, 65, 0.1);
  border: 1px solid var(--text-darker, #008f11);
  color: var(--text-green, #00cc33);
  padding: 2px 6px;
  border-radius: 3px;
  font-size: 10px;
  font-weight: 500;
}

/* Responsive design */
@media (max-width: 768px) {
  .category-post {
    flex-direction: column;
    align-items: flex-start;
  }
  
  .category-post .post-date {
    min-width: auto;
  }
  
  .category-post .post-title {
    min-width: auto;
    width: 100%;
  }
}
</style>
