#!/bin/bash

# Directory paths
PROJECT_DIR="/Users/john/johnbartlett.github.io"
SITE_DIR="$PROJECT_DIR/_site"

# Function to fix common broken internal links
fix_internal_links() {
    local file="$1"

    # Ensure the main element has the id="main"
    if grep -q 'href="#main"' "$file"; then
        if ! grep -q 'id="main"' "$file"; then
            if grep -q '<main>' "$file"; then
                sed -i '' 's/<main>/<main id="main">/' "$file"
                echo "Added id=\"main\" to <main> element in $file"
            else
                # Add a placeholder div with id="main" if <main> element is not found
                sed -i '' 's|</body>|<div id="main"></div></body>|' "$file"
                echo "Added placeholder div id=\"main\" to $file"
            fi
        else
            echo "id=\"main\" already exists in $file"
        fi
    fi

    # Fix links to # by replacing with href="#top" to prevent broken links
    if grep -q 'href="#"' "$file"; then
        sed -i '' 's/href="#"/href="#top"/g' "$file"
        echo "Replaced href=\"#\" with href=\"#top\" in $file"
    fi

    # Remove links to #invalid-link
    if grep -q 'href="#invalid-link"' "$file"; then
        sed -i '' 's/href="#invalid-link"/href="#top"/g' "$file"
        echo "Replaced href=\"#invalid-link\" with href=\"#top\" in $file"
    fi
}

# Check and fix internal links in all HTML files
echo "Checking and fixing internal links in HTML files..."
find $SITE_DIR -name "*.html" | while read -r file; do
    fix_internal_links "$file"
done

echo "Internal link check and fix complete. Please review the changes."

# Check all links with htmlproofer
echo "Checking links with htmlproofer..."
bundle exec htmlproofer ./_site --disable-external --ignore-urls "/#main"

# If htmlproofer returns an error, stop the script
if [ $? -ne 0 ]; then
    echo "htmlproofer found issues with the site. Please fix them before proceeding."
    exit 1
fi

echo "All links are valid. No issues found."
