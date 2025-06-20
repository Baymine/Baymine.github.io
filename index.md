---
layout: default
title: Home
---

<div class="hacker-homepage">
  <!-- Terminal Header -->
  <div class="terminal-header">
    <div class="terminal-controls">
      <span class="control close"></span>
      <span class="control minimize"></span>
      <span class="control maximize"></span>
    </div>
    <div class="terminal-title">baymine@github:~$</div>
  </div>

  <!-- Main Terminal Content -->
  <div class="terminal-content">
    <div class="terminal-line">
      <span class="prompt">root@baymine:~#</span>
      <span class="command typing-animation">whoami</span>
    </div>

    <div class="output-section">
      <div class="ascii-art">
        <pre>
██████╗  █████╗ ██╗   ██╗███╗   ███╗██╗███╗   ██╗███████╗
██╔══██╗██╔══██╗╚██╗ ██╔╝████╗ ████║██║████╗  ██║██╔════╝
██████╔╝███████║ ╚████╔╝ ██╔████╔██║██║██╔██╗ ██║█████╗
██╔══██╗██╔══██║  ╚██╔╝  ██║╚██╔╝██║██║██║╚██╗██║██╔══╝
██████╔╝██║  ██║   ██║   ██║ ╚═╝ ██║██║██║ ╚████║███████╗
╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝     ╚═╝╚═╝╚═╝  ╚═══╝╚══════╝
        </pre>
      </div>

      <div class="info-grid">
        <div class="info-item">
          <span class="label">USER:</span>
          <span class="value">York Cao</span>
        </div>
        <div class="info-item">
          <span class="label">ROLE:</span>
          <span class="value">Data Engineer</span>
        </div>
        <div class="info-item">
          <span class="label">LOCATION:</span>
          <span class="value">Beijing, China</span>
        </div>
        <div class="info-item">
          <span class="label">STATUS:</span>
          <span class="value blink">ONLINE</span>
        </div>
      </div>
    </div>

    <div class="terminal-line">
      <span class="prompt">root@baymine:~#</span>
      <span class="command">cat /etc/skills</span>
    </div>

    <div class="skills-section">
      <div class="skill-category">
        <h3>// CORE_TECHNOLOGIES</h3>
        <div class="skill-tags">
          <span class="skill-tag">ClickHouse</span>
          <span class="skill-tag">C++</span>
          <span class="skill-tag">Python</span>
          <span class="skill-tag">Database Systems</span>
          <span class="skill-tag">Distributed Systems</span>
        </div>
      </div>

      <div class="skill-category">
        <h3>// RESEARCH_AREAS</h3>
        <div class="skill-tags">
          <span class="skill-tag">Operating Systems</span>
          <span class="skill-tag">Computer Networks</span>
          <span class="skill-tag">System Programming</span>
          <span class="skill-tag">Performance Optimization</span>
        </div>
      </div>
    </div>

    <div class="terminal-line">
      <span class="prompt">root@baymine:~#</span>
      <span class="command">ls -la /blog/recent_posts</span>
    </div>

    <div class="posts-section">
      {% for post in site.posts limit:5 %}
      <div class="post-item">
        <span class="file-permissions">-rw-r--r--</span>
        <span class="file-date">{{ post.date | date: "%b %d" }}</span>
        <a href="{{ post.url }}" class="file-name">{{ post.title | default: "Untitled" }}</a>
      </div>
      {% endfor %}
    </div>

    <div class="terminal-line">
      <span class="prompt">root@baymine:~#</span>
      <span class="command">./explore_blog.sh</span>
    </div>

    <div class="navigation-section">
      <div class="nav-item">
        <a href="/about/" class="nav-link">[ABOUT]</a>
        <span class="nav-desc">Learn more about me</span>
      </div>
      <div class="nav-item">
        <a href="https://github.com/Baymine" class="nav-link">[GITHUB]</a>
        <span class="nav-desc">Check out my repositories</span>
      </div>
      <div class="nav-item">
        <a href="/feed.xml" class="nav-link">[RSS]</a>
        <span class="nav-desc">Subscribe to updates</span>
      </div>
    </div>

    <div class="terminal-line">
      <span class="prompt">root@baymine:~#</span>
      <span class="cursor blink">█</span>
    </div>
  </div>
</div>

<script src="{{ '/assets/js/hacker-effects.js' | relative_url }}"></script>
