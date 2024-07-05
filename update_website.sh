#!/bin/bash

# Directory of your website
website_dir="/Users/john/johnbartlett.github.io"

# Check and navigate to the CSS directory
if [ -d "$website_dir/css" ]; then
  cd "$website_dir/css"
else
  echo "CSS directory not found, checking in website root..."
  cd "$website_dir"
fi

# Update or create CSS for sticky navigation
echo "Adding or updating sticky navigation in CSS..."
if [ -f "style.css" ]; then
  sed -i '' '/nav {/a\
  position: -webkit-sticky; /* Safari */\
  position: sticky;\
  top: 0;\
  background-color: #fff;\
  z-index: 1000;\
  ' style.css
else
  echo "nav {" >> style.css
  echo "  position: -webkit-sticky; /* Safari */" >> style.css
  echo "  position: sticky;" >> style.css
  echo "  top: 0;" >> style.css
  echo "  background-color: #fff;" >> style.css
  echo "  z-index: 1000;" >> style.css
  echo "}" >> style.css
fi

# Navigate back to the root directory
cd "$website_dir"

# Update HTML files with alt attributes
echo "Adding alt attributes to images in HTML files..."
find . -name '*.html' -exec sed -i '' '/<img /s/ alt="[^"]*"//g' {} \;
find . -name '*.html' -exec sed -i '' '/<img /s/>/ alt="Image description here" >/g' {} \;

echo "Updates completed. Please check and refine alt attributes manually."
