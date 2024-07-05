#!/bin/bash

# --- Configuration ---
SITE_DIR=$(git rev-parse --show-toplevel)
CONFIG_FILE="_config.yml"
BLOG_TREE_FILE="_pages/blog-tree.md"
POSTS_DIR="_posts"
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
check_and_fix_link() {
    local orphaned_link="$1"
    local found_match=false

    # Check if the link exists with correct case
    for category in $(find "$POSTS_DIR" -name "*.md" -exec grep -hoP '(?<=categories: \[).*(?=\])' {} \; | tr '[:upper:]' '[:lower:]' | sort -u); do
        if [[ "$orphaned_link" == "/categories/$category" ]]; then
            echo "Fixing case for link: $orphaned_link -> /categories/$category"
            sed -i '' "s|$orphaned_link|/categories/$category|" "$BLOG_TREE_FILE"
            found_match=true
            break
        fi
    done

    # If no match found, add a redirect
    if ! $found_match; then
        local target_link=$(echo "$orphaned_link" | sed 's|/categories/|/categories/blog/|')  # Assuming 'blog' is the default category
        echo "Adding redirect for orphaned link: $orphaned_link -> $target_link"

        # Use 'yq' for YAML manipulation if available, otherwise use 'sed'
        if command -v yq &> /dev/null; then
            yq eval ".redirects += {\"$orphaned_link\": \"$target_link\"}" -i "$CONFIG_FILE"
        else
            echo "  - \"$orphaned_link\": \"$target_link\"" >> "$CONFIG_FILE"
        fi
    fi
}

build_and_deploy() {
    echo "Installing dependencies..."
    bundle install

    echo "Building site..."
    bundle exec jekyll build

    echo "Deploying to GitHub Pages..."
    git add .
    git commit -m "Fix orphaned category links"
    git push origin main
    echo "Deployment complete. Changes may take a few minutes to appear on your site."
}

# --- Main Script ---
cd "$SITE_DIR" || exit 1

for link in "${ORPHANED_LINKS[@]}"; do
    check_and_fix_link "$link"
done

build_and_deploy

