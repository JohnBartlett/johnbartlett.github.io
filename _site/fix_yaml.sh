#!/bin/bash
# --- Configuration ---
POSTS_DIR="_posts"

# --- Functions ---
fix_yaml() {
  local file="$1"

  # Fix spacing around the colon after categories and tags
  sed -i '' 's/categories:\s\+[-] /\
categories:\
  - /' "$file"
  sed -i '' 's/tags:\s\+[-] /\
tags:\
  - /' "$file"
  
  # Remove any extra colons after "title:" and "date:"
  sed -i '' 's/title: *: */title: /' "$file"
  sed -i '' 's/date: *: */date: /' "$file"

  # Add a space after each remaining colon
  sed -i '' 's/:/: /g' "$file"

  # Convert the date format
  sed -i '' 's/\(date: \)\([0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}\)T[0-9]\{2\}:[0-9]\{2\}:[0-9]\{2\}-[0-9]\{2\}:[0-9]\{2\}/\1\2/' "$file"

  # Add quotes to title ONLY if it doesn't already have them
  sed -i '' '/^title: *[^"]/ s/^\(title:\s*\)\(.*\)/\1\"\2\"/' "$file"  
}

# --- Main Script ---
echo "Fixing YAML front matter in Jekyll posts..."

for file in "$POSTS_DIR"/*.md; do
  fix_yaml "$file"
done

echo "YAML fix complete."
