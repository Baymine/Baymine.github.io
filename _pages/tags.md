---
layout: page
title: Tags
permalink: /tags/
---

# Tags

Explore posts by tags to find specific topics and technologies.

## Tag Cloud

<div class="tag-cloud">
{% assign tags = site.tags | sort %}
{% for tag in tags %}
  <a href="#tag-{{ tag[0] | slugify }}" class="tag-cloud-item" data-count="{{ tag[1].size }}">
    {{ tag[0] }} ({{ tag[1].size }})
  </a>
{% endfor %}
</div>

## Posts by Tag

{% for tag in tags %}
<div id="tag-{{ tag[0] | slugify }}" class="tag-section">
  <h3>{{ tag[0] }}</h3>
  <div class="tag-info">
    <span class="post-count">{{ tag[1].size }} posts</span>
  </div>
  
  <div class="tag-posts">
    {% for post in tag[1] %}
    <div class="tag-post">
      <span class="post-date">{{ post.date | date: "%Y-%m-%d" }}</span>
      <a href="{{ post.url }}" class="post-title">{{ post.title | default: "Untitled" }}</a>
      {% if post.categories and post.categories.size > 0 %}
      <span class="post-categories">
        {% for category in post.categories %}
          <span class="category">{{ category }}</span>
        {% endfor %}
      </span>
      {% endif %}
    </div>
    {% endfor %}
  </div>
</div>
{% endfor %}

<style>
/* Tag cloud styles */
.tag-cloud {
  margin: 30px 0;
  padding: 20px;
  border: 1px solid var(--text-darker, #008f11);
  border-radius: 6px;
  background: rgba(0, 255, 65, 0.02);
  display: flex;
  flex-wrap: wrap;
  gap: 10px;
  align-items: center;
  justify-content: center;
}

.tag-cloud-item {
  color: var(--text-green, #00cc33);
  text-decoration: none;
  padding: 5px 10px;
  border: 1px solid var(--text-darker, #008f11);
  border-radius: 15px;
  background: rgba(0, 255, 65, 0.05);
  font-size: 12px;
  font-weight: 500;
  transition: all 0.3s ease;
  white-space: nowrap;
}

.tag-cloud-item:hover {
  color: var(--primary-green, #00ff41);
  border-color: var(--primary-green, #00ff41);
  background: rgba(0, 255, 65, 0.1);
  text-shadow: 0 0 10px rgba(0, 255, 65, 0.5);
  transform: scale(1.05);
}

/* Size tags based on post count */
.tag-cloud-item[data-count="1"] { font-size: 10px; }
.tag-cloud-item[data-count="2"] { font-size: 11px; }
.tag-cloud-item[data-count="3"] { font-size: 12px; }
.tag-cloud-item[data-count="4"] { font-size: 13px; }
.tag-cloud-item[data-count="5"] { font-size: 14px; }

/* Tag section styles */
.tag-section {
  margin: 40px 0;
  padding: 20px;
  border: 1px solid var(--text-darker, #008f11);
  border-radius: 6px;
  background: rgba(0, 255, 65, 0.02);
}

.tag-section h3 {
  color: var(--primary-green, #00ff41);
  margin: 0 0 15px 0;
  padding-bottom: 10px;
  border-bottom: 1px solid rgba(0, 255, 65, 0.2);
  text-shadow: 0 0 10px rgba(0, 255, 65, 0.5);
}

.tag-info {
  margin-bottom: 15px;
}

.tag-info .post-count {
  color: var(--text-dim, #00cc33);
  font-size: 14px;
  font-weight: 500;
}

.tag-posts {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.tag-post {
  display: flex;
  align-items: center;
  padding: 8px 12px;
  border: 1px solid rgba(0, 255, 65, 0.1);
  border-radius: 4px;
  background: rgba(0, 255, 65, 0.01);
  transition: all 0.3s ease;
  flex-wrap: wrap;
  gap: 10px;
}

.tag-post:hover {
  background: rgba(0, 255, 65, 0.05);
  border-color: var(--text-darker, #008f11);
  transform: translateX(5px);
}

.tag-post .post-date {
  color: var(--text-darker, #008f11);
  font-size: 12px;
  font-family: 'Fira Code', monospace;
  min-width: 100px;
  flex-shrink: 0;
}

.tag-post .post-title {
  color: var(--text-green, #00ff41);
  text-decoration: none;
  font-weight: 500;
  flex: 1;
  min-width: 200px;
}

.tag-post .post-title:hover {
  color: var(--primary-green, #00ff41);
  text-shadow: 0 0 10px rgba(0, 255, 65, 0.5);
}

.tag-post .post-categories {
  display: flex;
  gap: 5px;
  flex-wrap: wrap;
}

.tag-post .category {
  background: rgba(0, 255, 65, 0.1);
  border: 1px solid var(--text-darker, #008f11);
  color: var(--text-green, #00cc33);
  padding: 2px 6px;
  border-radius: 3px;
  font-size: 10px;
  font-weight: 500;
}

/* Smooth scrolling for anchor links */
html {
  scroll-behavior: smooth;
}

/* Responsive design */
@media (max-width: 768px) {
  .tag-cloud {
    justify-content: flex-start;
  }
  
  .tag-post {
    flex-direction: column;
    align-items: flex-start;
  }
  
  .tag-post .post-date {
    min-width: auto;
  }
  
  .tag-post .post-title {
    min-width: auto;
    width: 100%;
  }
}
</style>
