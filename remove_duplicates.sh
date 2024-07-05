#!/bin/bash

# Directory of your website
website_dir="/Users/john/johnbartlett.github.io"

# Navigate to the directory containing your HTML files
cd "$website_dir"

# Create a backup directory for original files
backup_dir="$website_dir/backup_$(date +%Y%m%d%H%M%S)"
mkdir -p "$backup_dir"

# Find all HTML files and back them up
echo "Backing up HTML files..."
find . -name '*.html' -exec cp {} "$backup_dir" \;

# Function to remove duplicate lines in a file
remove_duplicates() {
  awk '!seen[$0]++' "$1" > "$1.tmp" && mv "$1.tmp" "$1"
}

# Find and process each HTML file to remove duplicates
echo "Removing duplicate lines in HTML files..."
find . -name '*.html' -print0 | while IFS= read -r -d '' file; do
  echo "Processing $file..."
  remove_duplicates "$file"
done

echo "Duplicate removal completed. Original files are backed up in $backup_dir."
