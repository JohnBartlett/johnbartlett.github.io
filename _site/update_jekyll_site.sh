#!/bin/bash

# Update index.md
cat > index.md << EOL
---
layout: home
author_profile: true
---

# Welcome to John Bartlett's AI Consulting

Specializing in cutting-edge AI solutions for businesses. With years of experience in machine learning and data science, I help companies leverage the power of AI to drive innovation and efficiency.

## Services
- AI Strategy Development
- Machine Learning Implementation
- Data Science Consulting
- AI Training and Workshops

## Recent Posts
EOL

# Update _config.yml
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

# Outputting
permalink: /:categories/:title/
paginate: 5 # amount of posts to show
paginate_path: /page:num/

# Plugins
plugins:
  - jekyll-paginate
  - jekyll-sitemap
  - jekyll-gist
  - jekyll-feed
  - jemoji
  - jekyll-include-cache

# Archives
category_archive:
  type: liquid
  path: /categories/
tag_archive:
  type: liquid
  path: /tags/

# HTML Compression
compress_html:
  clippings: all
  ignore:
    envs: development
EOL

# Update navigation.yml
mkdir -p _data
cat > _data/navigation.yml << EOL
main:
  - title: "Home"
    url: /
  - title: "About"
    url: /about/
  - title: "Posts"
    url: /posts/
  - title: "Categories"
    url: /categories/
  - title: "Tags"
    url: /tags/
EOL

# Create about.md in _pages directory
mkdir -p _pages
cat > _pages/about.md << EOL
---
title: "About"
permalink: /about/
---

John Bartlett is an experienced AI consultant specializing in...

[Add more content about yourself and your expertise]
EOL

# Create posts.md in _pages directory
cat > _pages/posts.md << EOL
---
title: "Posts"
permalink: /posts/
layout: posts
author_profile: true
---
EOL

# Git commands to add, commit, and push changes
git add .
git commit -m "Fix layout issues and add navigation"
git push origin main

echo "Changes have been made and pushed to the main branch. Please wait a few minutes for GitHub Pages to rebuild your site."
