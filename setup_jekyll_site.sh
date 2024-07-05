#!/bin/bash

# Create necessary directories
mkdir -p _posts _pages assets/css _data

# Create or update _config.yml
cat > _config.yml <<EOL
remote_theme: "mmistakes/minimal-mistakes@4.24.0"
minimal_mistakes_skin: "air"
locale: "en-US"
title: "John Bartlett - AI Consultant"
subtitle: "Innovative AI Solutions"
name: "John Bartlett"
description: "AI Solutions and Consulting for the Modern Business"
url: "https://johnbartlett.github.io"
baseurl: ""
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

# Plugins
plugins:
  - jekyll-paginate
  - jekyll-sitemap
  - jekyll-gist
  - jekyll-feed
  - jemoji
  - jekyll-include-cache

# Sass/SCSS
sass:
  sass_dir: assets/css
  style: compressed

# Outputting
permalink: /:categories/:title/
paginate: 5
paginate_path: /page:num/

# Archives
category_archive:
  type: liquid
  path: /categories/
tag_archive:
  type: liquid
  path: /tags/

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

# Reading Files
include:
  - _pages

# HTML Compression
compress_html:
  clippings: all
  ignore:
    envs: development
EOL

# Create or update navigation.yml
cat > _data/navigation.yml <<EOL
main:
  - title: "Home"
    url: /
  - title: "About"
    url: /about/
  - title: "Blog Tree"
    url: /blog-tree/
  - title: "Categories"
    url: /categories/
  - title: "Tags"
    url: /tags/
EOL

# Create or update custom.scss
cat > assets/css/custom.scss <<EOL
---
---

@import "minimal-mistakes/skins/{{ site.minimal_mistakes_skin | default: 'default' }}";
@import "minimal-mistakes";

// Add your custom CSS here
EOL

# Create index.md
cat > index.md <<EOL
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

{% for post in site.posts limit:5 %}
  <h3><a href="{{ post.url }}">{{ post.title }}</a></h3>
  <p>{{ post.date | date: "%B %d, %Y" }}</p>
  {{ post.excerpt }}
{% endfor %}
EOL

# Function to create a blog post
create_post() {
    local date=$1
    local title=$2
    local categories=$3
    local tags=$4
    local content=$5
    
    local filename="_posts/${date}-${title// /-}.md"
    echo "---
title: \"$title\"
date: $date
categories:
$categories
tags:
$tags
---

$content

[Rest of the blog post content]" > "$filename"
    
    echo "Created $filename"
}

# Create sample blog posts
create_post "2023-06-28" "The Revolution of Generative AI in Content Creation" \
"  - AI
  - Generative AI" \
"  - AI
  - Generative AI
  - Content Creation" \
"Generative AI is transforming how we create content across various industries..."

create_post "2023-06-29" "Emerging Trends in AI: What to Watch in 2023" \
"  - AI
  - New AI" \
"  - AI
  - Trends
  - Innovation" \
"As we move further into 2023, several exciting trends are shaping the AI landscape..."

create_post "2023-06-30" "Developing a Robust AI Strategy for Your Business" \
"  - AI
  - AI Strategy" \
"  - AI
  - Business Strategy
  - Digital Transformation" \
"In today's rapidly evolving technological landscape, having a solid AI strategy is crucial for businesses..."

# Add more create_post calls for additional sample posts

# Git commands to add, commit, and push changes
git add .
git commit -m "Set up Jekyll site with Minimal Mistakes theme and sample posts"
git push origin clean-slate

echo "Jekyll site set up complete. Changes have been committed and pushed to the clean-slate branch."
