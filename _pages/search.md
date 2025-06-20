---
layout: page
title: Search
permalink: /search/
---

# Search Posts

Find specific content across all blog posts.

<div class="search-container">
  <div class="terminal-line">
    <span class="prompt">root@baymine:~#</span>
    <span class="command">grep -r "</span>
    <input type="text" id="search-input" placeholder="search term" class="search-input">
    <span class="command">" /blog/posts/</span>
  </div>
  
  <div id="search-results" class="search-results">
    <div class="search-info">
      <p>Enter a search term to find posts containing that text.</p>
      <p>Search includes post titles, content, categories, and tags.</p>
    </div>
  </div>
</div>

<!-- All posts data for JavaScript search -->
<script>
const posts = [
  {% for post in site.posts %}
  {
    title: {{ post.title | default: "Untitled" | jsonify }},
    url: {{ post.url | jsonify }},
    date: {{ post.date | date: "%Y-%m-%d" | jsonify }},
    categories: {{ post.categories | jsonify }},
    tags: {{ post.tags | jsonify }},
    content: {{ post.content | strip_html | truncate: 300 | jsonify }}
  }{% unless forloop.last %},{% endunless %}
  {% endfor %}
];

// Simple search functionality
function performSearch(query) {
  const resultsContainer = document.getElementById('search-results');
  
  if (!query || query.length < 2) {
    resultsContainer.innerHTML = `
      <div class="search-info">
        <p>Enter at least 2 characters to search.</p>
      </div>
    `;
    return;
  }
  
  const results = posts.filter(post => {
    const searchText = (
      post.title + ' ' + 
      post.content + ' ' + 
      (post.categories || []).join(' ') + ' ' + 
      (post.tags || []).join(' ')
    ).toLowerCase();
    
    return searchText.includes(query.toLowerCase());
  });
  
  if (results.length === 0) {
    resultsContainer.innerHTML = `
      <div class="search-info">
        <p>No posts found matching "${query}".</p>
        <p>Try different keywords or check the <a href="/archives/">archives</a>.</p>
      </div>
    `;
    return;
  }
  
  const resultsHtml = `
    <div class="search-info">
      <p>Found ${results.length} post${results.length === 1 ? '' : 's'} matching "${query}":</p>
    </div>
    <div class="search-posts">
      ${results.map(post => `
        <div class="search-post">
          <span class="post-date">${post.date}</span>
          <a href="${post.url}" class="post-title">${post.title}</a>
          <div class="post-excerpt">${post.content}</div>
          ${post.categories && post.categories.length > 0 ? `
            <div class="post-meta">
              Categories: ${post.categories.map(cat => `<span class="category">${cat}</span>`).join(' ')}
            </div>
          ` : ''}
          ${post.tags && post.tags.length > 0 ? `
            <div class="post-meta">
              Tags: ${post.tags.map(tag => `<span class="tag">${tag}</span>`).join(' ')}
            </div>
          ` : ''}
        </div>
      `).join('')}
    </div>
  `;
  
  resultsContainer.innerHTML = resultsHtml;
}

// Set up search functionality
document.addEventListener('DOMContentLoaded', function() {
  const searchInput = document.getElementById('search-input');
  let searchTimeout;
  
  searchInput.addEventListener('input', function() {
    clearTimeout(searchTimeout);
    searchTimeout = setTimeout(() => {
      performSearch(this.value);
    }, 300);
  });
  
  // Focus on search input when page loads
  searchInput.focus();
});
</script>

<style>
/* Search page specific styles */
.search-container {
  margin: 20px 0;
}

.search-input {
  background: transparent;
  border: none;
  color: var(--text-green, #00ff41);
  font-family: 'Fira Code', monospace;
  font-size: 14px;
  outline: none;
  min-width: 200px;
  border-bottom: 1px solid var(--text-darker, #008f11);
  padding: 2px 5px;
}

.search-input:focus {
  border-bottom-color: var(--primary-green, #00ff41);
  box-shadow: 0 1px 0 var(--primary-green, #00ff41);
}

.search-input::placeholder {
  color: var(--text-darker, #008f11);
  font-style: italic;
}

.search-results {
  margin: 30px 0;
  padding: 20px;
  border: 1px solid var(--text-darker, #008f11);
  border-radius: 6px;
  background: rgba(0, 255, 65, 0.02);
  min-height: 200px;
}

.search-info {
  color: var(--text-dim, #00cc33);
  font-size: 14px;
  margin-bottom: 20px;
}

.search-info p {
  margin: 5px 0;
}

.search-info a {
  color: var(--primary-green, #00ff41);
  text-decoration: none;
}

.search-info a:hover {
  text-shadow: 0 0 10px rgba(0, 255, 65, 0.5);
}

.search-posts {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.search-post {
  padding: 15px;
  border: 1px solid rgba(0, 255, 65, 0.1);
  border-radius: 4px;
  background: rgba(0, 255, 65, 0.01);
  transition: all 0.3s ease;
}

.search-post:hover {
  background: rgba(0, 255, 65, 0.05);
  border-color: var(--text-darker, #008f11);
}

.search-post .post-date {
  color: var(--text-darker, #008f11);
  font-size: 12px;
  font-family: 'Fira Code', monospace;
  display: block;
  margin-bottom: 5px;
}

.search-post .post-title {
  color: var(--text-green, #00ff41);
  text-decoration: none;
  font-weight: 500;
  font-size: 16px;
  display: block;
  margin-bottom: 10px;
}

.search-post .post-title:hover {
  color: var(--primary-green, #00ff41);
  text-shadow: 0 0 10px rgba(0, 255, 65, 0.5);
}

.search-post .post-excerpt {
  color: var(--text-dim, #00cc33);
  font-size: 14px;
  line-height: 1.5;
  margin-bottom: 10px;
}

.search-post .post-meta {
  margin: 5px 0;
  font-size: 12px;
}

.search-post .category,
.search-post .tag {
  background: rgba(0, 255, 65, 0.1);
  border: 1px solid var(--text-darker, #008f11);
  color: var(--text-green, #00cc33);
  padding: 2px 6px;
  border-radius: 3px;
  font-size: 10px;
  margin-right: 5px;
  display: inline-block;
}

/* Responsive design */
@media (max-width: 768px) {
  .search-input {
    min-width: 150px;
    width: 100%;
    margin-top: 10px;
  }
  
  .terminal-line {
    flex-wrap: wrap;
  }
}
</style>
