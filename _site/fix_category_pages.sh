#!/bin/bash

# Backup the current site
timestamp=$(date +"%Y%m%d_%H%M%S")
backup_dir="../johnbartlett.github.io_backup_$timestamp"
mkdir -p "$backup_dir"
cp -R * "$backup_dir"

echo "Backup created in $backup_dir"

# Update Gemfile to include necessary plugins
if ! grep -q "jekyll-archives" Gemfile; then
    echo "gem 'jekyll-archives'" >> Gemfile
fi

# Update _config.yml to ensure category and tag archives are set up correctly
cat > _config.yml << EOL
# Theme Settings
remote_theme: "mmistakes/minimal-mistakes@4.24.0"
minimal_mistakes_skin: "air"
breadcrumbs: true

# Site Settings
locale: "en-US"
title: "John Bartlett - AI Consultant"
title_separator: "-"
subtitle: "Innovative AI Solutions"
name: "John Bartlett"
description: "AI Solutions and Consulting for the Modern Business"
url: "https://johnbartlett.github.io"
baseurl: ""
repository: "JohnBartlett/johnbartlett.github.io"
logo: "/assets/images/logo.png"
search: true

# Site Author
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

# Site Footer
footer:
  links:
    - label: "LinkedIn"
      icon: "fab fa-fw fa-linkedin"
      url: "https://www.linkedin.com/in/yourprofile/"
    - label: "GitHub"
      icon: "fab fa-fw fa-github"
      url: "https://github.com/JohnBartlett"

# Outputting
permalink: /:categories/:title/
paginate: 5 # amount of posts to show
paginate_path: /page:num/

# Archives
category_archive:
  type: jekyll-archives
  path: /categories/
tag_archive:
  type: jekyll-archives
  path: /tags/
jekyll-archives:
  enabled:
    - categories
    - tags
  layouts:
    category: archive-taxonomy
    tag: archive-taxonomy
  permalinks:
    category: /categories/:name/
    tag: /tags/:name/

# Plugins
plugins:
  - jekyll-paginate
  - jekyll-sitemap
  - jekyll-gist
  - jekyll-feed
  - jemoji
  - jekyll-include-cache
  - jekyll-archives

# Defaults
defaults:
  # _posts
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
  # _pages
  - scope:
      path: "_pages"
      type: pages
    values:
      layout: single
      author_profile: true

# HTML Compression
compress_html:
  clippings: all
  ignore:
    envs: development
EOL

# Update the blog-tree.md file
cat > _pages/blog-tree.md << EOL
---
title: "Blog Categories"
layout: categories
permalink: /blog-tree/
author_profile: true
---

Here's a list of all the categories on this blog:

{% for category in site.categories %}
  <h2>{{ category[0] }}</h2>
  <ul>
    {% for post in category[1] %}
      <li><a href="{{ post.url | relative_url }}">{{ post.title }}</a></li>
    {% endfor %}
  </ul>
{% endfor %}
EOL

# Ensure all blog posts have proper front matter with categories
for file in _posts/*.md; do
    if ! grep -q "categories:" "$file"; then
        sed -i '' '1r /dev/stdin' "$file" << EOL

categories:
  - Blog
EOL
    fi
done

# Update navigation to ensure blog tree link is correct
sed -i '' 's/url: \/blog-tree\//url: \/categories\//' _data/navigation.yml

# Run bundle install to ensure all necessary gems are installed
bundle install

# Build the site locally to test
bundle exec jekyll build

# Commit changes
git add .
git commit -m "Fix category pages and update configuration"

# Push changes to GitHub
git push origin main

echo "Changes have been made, committed, and pushed to GitHub."
echo "Please wait a few minutes for GitHub Pages to rebuild your site."
echo "To roll back changes, restore from the backup directory: $backup_dir"
