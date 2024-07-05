#!/bin/bash
# --- Configuration ---
POSTS_DIR="_posts"

# --- Functions ---
fix_yaml_indentation() {
  local file="$1"
  
  # Fix spacing around the colon after categories and tags
  sed -i '' 's/categories:\s\+[-] /\
categories:\
  - /' "$file"
  sed -i '' 's/tags:\s\+[-] /\
tags:\
  - /' "$file"

  # Add a space after each colon 
  sed -i '' 's/:/: /g' "$file"
}

# --- Main Script ---
echo "Fixing YAML indentation and spacing in Jekyll posts..."
for file in "$POSTS_DIR"/*.md; do
  fix_yaml_indentation "$file"
done
echo "YAML fix complete."
