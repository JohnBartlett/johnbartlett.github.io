#!/bin/bash

# Backup the current site
timestamp=$(date +"%Y%m%d_%H%M%S")
backup_dir="../johnbartlett.github.io_backup_$timestamp"
mkdir -p "$backup_dir"
cp -R * "$backup_dir"

echo "Backup created in $backup_dir"

# Update _config.yml
cat > _config.yml << EOL
remote_theme: "mmistakes/minimal-mistakes@4.24.0"
minimal_mistakes_skin: "air"
locale: "en-US"
title: "John Bartlett - AI Consultant"
subtitle: "Innovative AI Solutions"
name: "John Bartlett"
description: "AI Solutions and Consulting for the Modern Business"
url: "https://johnbartlett.github.io"
baseurl: ""
repository: "JohnBartlett/johnbartlett.github.io"
logo: "/assets/images/logo.png"
search: true

author:
  name: "John Bartlett"
  avatar: "/assets/images/profile.jpg"
  bio: "AI Consultant specializing in machine learning and data science"
  location: "Your Location"
  links:
    - label: "Email"
      icon: "fas fa-fw fa-envelope-square"
      url: "mailto:your.email@example.com"
    - label: "LinkedIn"
      icon: "fab fa-fw fa-linkedin"
      url: "https://www.linkedin.com/in/yourprofile/"
    - label: "GitHub"
      icon: "fab fa-fw fa-github"
      url: "https://github.com/JohnBartlett"

footer:
  links:
    - label: "LinkedIn"
      icon: "fab fa-fw fa-linkedin"
      url: "https://www.linkedin.com/in/yourprofile/"
    - label: "GitHub"
      icon: "fab fa-fw fa-github"
      url: "https://github.com/JohnBartlett"

permalink: /:categories/:title/
paginate: 5
paginate_path: /page:num/

include:
  - _pages

# Collections
collections:
  categories:
    output: true
    permalink: /:collection/:name/

defaults:
  - scope:
      path: ""
      type: posts
    values:
      layout: single
      author_profile: true
      read_time: true
      comments: false
      share: true
      related: true
  - scope:
      path: "_pages"
      type: pages
    values:
      layout: single
      author_profile: true
  - scope:
      path: ""
      type: categories
    values:
      layout: category
      author_profile: true

category_archive:
  type: liquid
  path: /categories/
tag_archive:
  type: liquid
  path: /tags/

plugins:
  - jekyll-paginate
  - jekyll-sitemap
  - jekyll-gist
  - jekyll-feed
  - jemoji
  - jekyll-include-cache

compress_html:
  clippings: all
  ignore:
    envs: development
EOL

# Update blog-tree.md
mkdir -p _pages
cat > _pages/blog-tree.md << EOL
---
title: "Blog Categories"
layout: categories
permalink: /blog-tree/
author_profile: true
---

## Categories

{% for category in site.categories %}
  <h3>{{ category[0] }}</h3>
  <ul>
    {% for post in category[1] %}
      <li><a href="{{ post.url | relative_url }}">{{ post.title }}</a></li>
    {% endfor %}
  </ul>
{% endfor %}
EOL

# Create a layout for categories
mkdir -p _layouts
cat > _layouts/category.html << EOL
---
layout: archive
---

{{ content }}

<h2>Posts in "{{ page.category }}" category</h2>

{% for post in site.categories[page.category] %}
  {% include archive-single.html %}
{% endfor %}
EOL

# Create individual category pages
mkdir -p _categories
for category in $(grep -h "categories:" _posts/* | sed 's/categories://' | tr -d '[]' | tr ',' '\n' | sed 's/^ *//' | sort -u); do
  cat > "_categories/${category}.md" << EOL
---
title: "${category}"
layout: category
permalink: /categories/${category}/
taxonomy: ${category}
---

Posts in the ${category} category.
EOL
done

# Update navigation
cat > _data/navigation.yml << EOL
main:
  - title: "Home"
    url: /
  - title: "About"
    url: /about/
  - title: "Blog Categories"
    url: /blog-tree/
  - title: "All Posts"
    url: /posts/
EOL

# Ensure Gemfile has necessary gems
cat > Gemfile << EOL
source "https://rubygems.org"

gem "github-pages", group: :jekyll_plugins
gem "jekyll-include-cache"
gem "jekyll-paginate"
gem "jekyll-sitemap"
gem "jekyll-gist"
gem "jekyll-feed"
gem "jemoji"
EOL

# Run bundle install
bundle install

# Build the site locally
bundle exec jekyll build

# Commit and push changes
git add .
git commit -m "Fix blog categories and site structure"
git push origin main

echo "Changes have been made, committed, and pushed to GitHub."
echo "Please wait a few minutes for GitHub Pages to rebuild your site."
echo "To roll back changes, restore from the backup directory: $backup_dir"
