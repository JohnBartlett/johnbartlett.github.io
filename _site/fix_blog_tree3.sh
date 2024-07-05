#!/bin/bash

# --- Configuration ---
BACKUP_DIR="../johnbartlett.github.io_backup_$(date +"%Y%m%d_%H%M%S")"
CONFIG_FILE="_config.yml"
BLOG_TREE_FILE="_pages/blog-tree.md"
NAVIGATION_FILE="_data/navigation.yml"
POSTS_DIR="_posts"

# --- Functions ---
backup_site() {
  echo "Creating backup in $BACKUP_DIR..."
  mkdir -p "$BACKUP_DIR"
  cp -R * "$BACKUP_DIR"
  echo "Backup complete."
}

update_config() {
  echo "Updating $CONFIG_FILE..."
  # Use 'yq' for YAML manipulation if available, otherwise use 'sed'
  if command -v yq &> /dev/null; then
    yq eval '.category_archive.path = "/categories/" | .tag_archive.path = "/tags/"' -i "$CONFIG_FILE"
  else
    sed -i '' 's|path: /blog-tree/|path: /categories/|' "$CONFIG_FILE"
    sed -i '' 's|path: /blog-tags/|path: /tags/|' "$CONFIG_FILE"
  fi
  echo "Update complete."
}

update_blog_tree() {
  echo "Updating $BLOG_TREE_FILE..."
  cat > "$BLOG_TREE_FILE" << EOL
---
title: "Blog Categories"
layout: categories
permalink: /categories/
author_profile: true
---

Here's a list of all the categories on this blog:

{% for category in site.categories %}
  <h2><a href="{{ site.baseurl }}/categories/{{ category[0] | slugify }}">{{ category[0] }}</a></h2>
  <ul>
    {% for post in category[1] %}
      <li><a href="{{ post.url | relative_url }}">{{ post.title }}</a></li>
    {% endfor %}
  </ul>
{% endfor %}
EOL
  echo "Update complete."
}

update_navigation() {
  echo "Updating $NAVIGATION_FILE..."
  sed -i '' 's|url: /blog-tree/|url: /categories/|' "$NAVIGATION_FILE"
  echo "Update complete."
}

ensure_post_categories() {
  echo "Checking and updating post categories..."
  for file in "$POSTS_DIR"/*.md; do
    if ! yq eval '.' "$file" &> /dev/null; then  # Check YAML validity first
      echo "Invalid YAML in $file. Please fix before continuing."
      exit 1
    fi

    if ! grep -q "categories:" "$file"; then
      echo "Adding 'categories: [Blog]' to $file"
      sed -i '' '1i\
categories: [Blog]\
' "$file"
    else
      # Convert existing categories to lowercase
      sed -i '' 's/categories:.*/categories: [generative ai]/' "$file" 
    fi
  done
  echo "Check complete."
}

build_and_deploy() {
  echo "Installing dependencies..."
  bundle install 

  echo "Building site..."
  bundle exec jekyll build

  echo "Deploying to GitHub Pages..."
  git add .
  git commit -m "Fix category links, case sensitivity, and YAML errors in blog tree"
  git push origin main
  echo "Deployment complete. Changes may take a few minutes to appear on your site."
}

# --- Main Script ---
backup_site
update_config
update_blog_tree
update_navigation
ensure_post_categories
build_and_deploy

echo "All done! To roll back, restore from $BACKUP_DIR"
