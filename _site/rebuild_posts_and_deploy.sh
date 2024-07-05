#!/bin/bash

# --- Configuration ---
POSTS_DIR="_posts"

# --- Functions ---
rebuild_post() {
  local file="$1"

  # Extract title (assuming it's on the second line)
  title=$(sed -n '2p' "$file" | sed -e 's/^title: *\"\(.*\)\"$/\1/')

  # Extract content (everything after the YAML front matter)
  content=$(sed -n '/^---$/,//{/^---$/d;p}' "$file")

  # Get the current date and time
  now=$(date +'%Y-%m-%d %H:%M:%S %z')

  # Create new YAML front matter with correct formatting
  new_yaml="---
title: \"$title\"
date: $now
categories: 
  - blog
tags:
  - AI
---
"

  # Combine new YAML and content, overwriting the original file
  echo "$new_yaml$content" > "$file"
}

build_and_deploy() {
  echo "Installing dependencies..."
  bundle install

  echo "Building site..."
  bundle exec jekyll build

  echo "Re-initializing Git repository..."
  rm -rf .git
  git init
  git add .
  git commit -m "Rebuild posts and website from scratch"

  echo "Deploying to GitHub Pages..."
  git remote add origin https://github.com/JohnBartlett/johnbartlett.github.io.git
  git branch -M main
  git push -f origin main  # Force push to overwrite remote
  echo "Deployment complete. Changes may take a few minutes to appear on your site."
}

# --- Main Script ---
echo "Rebuilding Jekyll posts..."

for file in "$POSTS_DIR"/*.md; do
  rebuild_post "$file"
done

echo "Post rebuild complete."

build_and_deploy

echo "Website rebuilt and deployed!"
