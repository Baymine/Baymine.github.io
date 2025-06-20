source "https://rubygems.org"

# Jekyll compatible with Ruby 2.6
gem "jekyll", "~> 3.9.0"
gem "minima", "~> 2.5"

# Enhanced markdown support
gem "kramdown", "~> 2.3"
gem "kramdown-parser-gfm"
gem "rouge", "~> 3.26"

# Math support
gem "kramdown-math-katex"

# Jekyll plugins
group :jekyll_plugins do
  gem "jekyll-feed", "~> 0.12"
  gem "jekyll-sitemap"
  gem "jekyll-seo-tag"
  gem "jekyll-paginate"
  gem "jekyll-gist"
  gem "jekyll-github-metadata"
  gem "jekyll-include-cache"
end

# Windows and JRuby does not include zoneinfo files, so bundle the tzinfo-data gem
# and associated library.
platforms :mingw, :x64_mingw, :mswin, :jruby do
  gem "tzinfo", "~> 1.2"
  gem "tzinfo-data"
end

# Performance-booster for watching directories on Windows
gem "wdm", "~> 0.1.1", :platforms => [:mingw, :x64_mingw, :mswin]
