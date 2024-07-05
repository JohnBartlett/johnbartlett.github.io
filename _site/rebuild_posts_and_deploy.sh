#!/bin/bash

# --- Configuration ---
SITE_DIR="." 
POSTS_DIR="_posts"
CONFIG_FILE="_config.yml"
BLOG_TREE_FILE="_pages/blog-tree.md"
ORPHANED_LINKS=(
    "/categories/quantum"
    "/categories/generative-ai"
    "/categories/travels"
    "/categories/philosophy"
    "/categories/ml"
    "/categories/ai-strategy"
    "/categories/quantum-cryptography"
    "/categories/new-ai"
    "/categories/photos"
    "/categories/thoughts"
    "/categories/llms"
)

# --- Functions ---
#!/bin/bash

# Configuration and functions as before...

fix_yaml() {
  local file="$1"
  
  title=$(grep '^title: ' "$file" | sed 's/title: //' | sed 's/^"//;s/"$//')
  now=$(date +'%Y-%m-%d %H:%M:%S %z')

  new_yaml="---
title: \"$title\"
date: $now
categories:
  - blog
tags:
  - AI
---
"

  sed '/^---$/,/^---$/d' "$file" > tmpfile
  echo "$new_yaml" | cat - tmpfile > "$file"
  rm tmpfile
}

# Main script execution as before...

check_and_fix_link() {
    local orphaned_link="$1"
    local found_match=false

    # Check if the link exists with correct case
    # Use ggrep if available, otherwise fall back to grep -E
    if command -v ggrep &> /dev/null; then
        grep_cmd="ggrep -hoP"
    else
        grep_cmd="grep -hEo"
    fi

    for category in $(find "$POSTS_DIR" -name "*.md" -exec $grep_cmd '(?<=categories: \[).*(?=\])' {} \; | tr '[:upper:]' '[:lower:]' | sort -u); do
        if [[ "$orphaned_link" == "/categories/$category" ]]; then
            echo "Fixing case for link: $orphaned_link -> /categories/$category"
            sed -i '' "s|$orphaned_link|/categories/$category|" "$BLOG_TREE_FILE"
            found_match=true
            break
        fi
    done

    # If no match found, add a redirect
    if ! $found_match; then
        local target_link=$(echo "$orphaned_link" | sed 's|/categories/|/categories/blog/|') 
        echo "Adding redirect for orphaned link: $orphaned_link -> $target_link"

        # Use 'yq' if available, otherwise use 'sed'
        if command -v yq &> /dev/null; then
            yq eval ".redirects += {\"$orphaned_link\": \"$target_link\"}" -i "$CONFIG_FILE"
        else
            echo "  - \"$orphaned_link\": \"$target_link\"" >> "$CONFIG_FILE"
        fi
    fi
}

remove_include_cached() {
    local layout_file="$1"

    sed -i '' '/include_cached/d' "$layout_file"  
}

build_and_deploy() {
    echo "Checking theme..."
    if ! grep -q "remote_theme: \"mmistakes/minimal-mistakes" "$CONFIG_FILE"; then
        echo "Installing remote theme..."
        # Use 'yq' for YAML manipulation if available, otherwise use 'sed'
        if command -v yq &> /dev/null; then
            yq eval '.plugins += ["jekyll-remote-theme"] | .remote_theme = "mmistakes/minimal-mistakes@4.24.0"' -i "$CONFIG_FILE"
        else
            sed -i '' '/plugins:/a \  - jekyll-remote-theme' "$CONFIG_FILE"
            sed -i '' 's|theme:.*|remote_theme: "mmistakes/minimal-mistakes@4.24.0"|' "$CONFIG_FILE"
        fi
    fi
    echo "Theme ready."

    echo "Fixing layout files..."
    remove_include_cached "_layouts/default.html"

    echo "Installing dependencies..."
    bundle install

    echo "Building site..."
    bundle exec jekyll build

    echo "Re-initializing Git repository..."
    rm -rf .git
    git init
    git add .
    git commit -m "Rebuild website from scratch"

    echo "Deploying to GitHub Pages..."
    git remote add origin https://github.com/JohnBartlett/johnbartlett.github.io.git
    git branch -M main
    git push -f origin main 
    echo "Deployment complete. Changes may take a few minutes to appear on your site."
}

# --- Main Script ---
echo "Fixing YAML front matter in Jekyll posts..."
for file in "$POSTS_DIR"/*.md; do
  fix_yaml "$file"
done
echo "YAML fix complete."

for link in "${ORPHANED_LINKS[@]}"; do
    check_and_fix_link "$link"
done

build_and_deploy

echo "Website rebuilt and deployed!"
