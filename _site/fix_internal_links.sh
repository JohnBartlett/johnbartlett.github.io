#!/bin/bash

# Directory paths
PROJECT_DIR="/Users/john/johnbartlett.github.io"
SITE_DIR="$PROJECT_DIR/_site"

# Function to fix common broken internal links
fix_internal_links() {
    local file="$1"

    # Fix links to #main by adding id="main" to the first <main> element if missing
    if grep -q 'href="#main"' "$file"; then
        if ! grep -q 'id="main"' "$file"; then
            sed -i '' 's/<main/<main id="main"/' "$file"
            echo "Added id=\"main\" to <main> element in $file"
        fi
    fi

    # Remove links to "#" as they are invalid
    if grep -q 'href="#"' "$file"; then
        sed -i '' 's/href="#"/href="#invalid-link"/g' "$file"
        echo "Replaced href=\"#\" with href=\"#invalid-link\" in $file"
    fi
}

# Check and fix internal links in all HTML files
echo "Checking and fixing internal links in HTML files..."
find $SITE_DIR -name "*.html" | while read -r file; do
    fix_internal_links "$file"
done

echo "Internal link check and fix complete. Please review the changes."
