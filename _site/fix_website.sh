#!/bin/bash

# Directory of your website
website_dir="/Users/john/johnbartlett.github.io"

# Navigate to the directory containing your HTML files
cd "$website_dir"

# Fix duplicate title tags in HTML files
echo "Removing duplicate title tags in HTML files..."
find . -name '*.html' -exec sed -i '' '/<title>/,/<\/title>/!b; /<title>/n; /<title>/!d' {} \;

# Navigate to the CSS directory
if [ -d "$website_dir/css" ]; then
  cd "$website_dir/css"
else
  echo "CSS directory not found, using website root..."
  cd "$website_dir"
fi

# Update CSS for better aesthetics (example to improve typography and spacing)
echo "Updating CSS for better aesthetics..."
if [ -f "style.css" ]; then
  # Improve typography and spacing
  sed -i '' 's/font-family: .*/font-family: "Arial", sans-serif;/g' style.css
  sed -i '' 's/margin: .*/margin: 0 auto;/g' style.css
else
  echo "style.css not found, no CSS updates applied."
fi

echo "Website aesthetic updates applied. Please check your website."
