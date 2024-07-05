#!/bin/bash

# Directory containing your posts
POSTS_DIR="/Users/john/johnbartlett.github.io/_posts"

# Function to validate and correct YAML front matter
validate_and_correct_yaml() {
    local file="$1"
    local yaml_content title date categories tags

    # Extract current front matter
    yaml_content=$(yq e '... comments=""' "$file")
    title=$(echo "$yaml_content" | yq e '.title' -)
    date=$(echo "$yaml_content" | yq e '.date' -)
    categories=$(echo "$yaml_content" | yq e '.categories' -)
    tags=$(echo "$yaml_content" | yq e '.tags' -)

    # Validate front matter fields
    if [[ -z "$title" || -z "$date" || -z "$categories" || -z "$tags" ]]; then
        echo "Invalid or missing front matter in $file"

        # Check if any fields are missing and set defaults if necessary
        [[ -z "$title" ]] && title="Default Title"
        [[ -z "$date" ]] && date=$(date '+%Y-%m-%d %H:%M:%S %z')
        [[ -z "$categories" ]] && categories="[uncategorized]"
        [[ -z "$tags" ]] && tags="[untagged]"

        # Create corrected front matter
        corrected_front_matter=$(cat <<-EOF
---
title: "$title"
date: "$date"
categories: $categories
tags: $tags
---
EOF
        )

        # Write corrected front matter to file
        yq e -i '. |= load_str("'"$corrected_front_matter"'")' "$file"

        echo "Corrected front matter in $file"
    else
        echo "Valid front matter in $file"
    fi
}

# Loop through all posts
for post in "$POSTS_DIR"/*.md; do
    validate_and_correct_yaml "$post"
done

# Commit and push changes to GitHub
cd "$POSTS_DIR/../"
git add _posts/*.md
git commit -m "Fix YAML front matter in posts"
git push origin main

echo "YAML validation and correction complete. Changes pushed to GitHub."
