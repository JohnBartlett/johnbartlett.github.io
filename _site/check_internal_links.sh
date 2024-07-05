#!/bin/bash

# Directory paths
PROJECT_DIR="/Users/john/johnbartlett.github.io"
SITE_DIR="$PROJECT_DIR/_site"

# Function to check for broken internal links
check_internal_links() {
    local file="$1"
    grep -o 'href="#[^"]*"' "$file" | while read -r link; do
        local id=$(echo "$link" | sed 's/href="#//;s/"//')
        if ! grep -q "id=\"$id\"" "$file"; then
            echo "Broken link to #$id in $file"
        fi
    done
}

# Check internal links in all HTML files
echo "Checking internal links in HTML files..."
find $SITE_DIR -name "*.html" | while read -r file; do
    check_internal_links "$file"
done

echo "Internal link check complete. Please fix any reported issues."
