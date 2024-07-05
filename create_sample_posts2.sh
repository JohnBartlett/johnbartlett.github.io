#!/bin/bash

# Create necessary directories
mkdir -p _posts _pages assets/css _data

# Create _config.yml if it doesn't exist
if [ ! -f _config.yml ]; then
    echo "# Your _config.yml content here" > _config.yml
fi

# Create or update custom.scss
echo "// Your custom CSS here" > assets/css/custom.scss

# Create or update navigation.yml
echo "main:
  - title: \"Home\"
    url: /
  - title: \"About\"
    url: /about/
  - title: \"Blog Tree\"
    url: /blog-tree/
  - title: \"Categories\"
    url: /categories/
  - title: \"Tags\"
    url: /tags/" > _data/navigation.yml

# Create category and tag archive pages
echo "---
title: \"Posts by Category\"
layout: categories
permalink: /categories/
author_profile: true
---" > _pages/category-archive.md

echo "---
title: \"Posts by Tag\"
layout: tags
permalink: /tags/
author_profile: true
---" > _pages/tag-archive.md

# Create blog tree page
echo "---
title: \"Blog Categories\"
layout: single
permalink: /blog-tree/
---

## AI
- [Generative AI](/categories/generative-ai)
- [New AI](/categories/new-ai)
- [AI Strategy](/categories/ai-strategy)
- [LLMs](/categories/llms)

## Machine Learning
- [All ML Posts](/categories/ml)

## Quantum Computing
- [All Quantum Posts](/categories/quantum)

## Cryptography
- [Quantum Cryptography](/categories/quantum-cryptography)

## Personal
- [Travels](/categories/travels)
- [Photos](/categories/photos)
- [Thoughts](/categories/thoughts)
- [Philosophy](/categories/philosophy)" > _pages/blog-tree.md

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

# ... [Rest of the create_post function calls]

echo "All sample blog posts have been created."

# Git commands to add, commit, and push changes
git add _config.yml _pages/* assets/css/custom.scss _data/navigation.yml _posts/*
git commit -m "Update navigation, add blog tree, category/tag pages, and sample posts"
git push origin clean-slate

echo "Changes have been committed and pushed to the clean-slate branch."
