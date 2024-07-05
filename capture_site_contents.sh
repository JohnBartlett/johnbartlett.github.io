#!/bin/bash

OUTPUT_FILE="site_contents.txt"

# Function to print a separator
print_separator() {
    echo -e "\n=== $1 ===\n" >> "$OUTPUT_FILE"
}

# Function to list directory contents recursively
list_directory() {
    local dir=$1
    local prefix=$2
    for item in "$dir"/*; do
        if [ -d "$item" ]; then
            echo "${prefix}${item##*/}/" >> "$OUTPUT_FILE"
            list_directory "$item" "  $prefix"
        else
            echo "${prefix}${item##*/}" >> "$OUTPUT_FILE"
        fi
    done
}

# Clear the output file if it exists
> "$OUTPUT_FILE"

# Capture directory structure
print_separator "Directory Structure"
list_directory "." ""

# Capture _config.yml
print_separator "_config.yml"
cat _config.yml >> "$OUTPUT_FILE"

# Capture _data/navigation.yml
print_separator "_data/navigation.yml"
cat _data/navigation.yml >> "$OUTPUT_FILE" 2>/dev/null || echo "File not found" >> "$OUTPUT_FILE"

# Capture index.md or index.html
print_separator "index file"
if [ -f index.md ]; then
    cat index.md >> "$OUTPUT_FILE"
elif [ -f index.html ]; then
    cat index.html >> "$OUTPUT_FILE"
else
    echo "No index file found" >> "$OUTPUT_FILE"
fi

# Capture contents of _posts directory
print_separator "_posts directory"
for file in _posts/*.md; do
    if [ -f "$file" ]; then
        echo "File: $file" >> "$OUTPUT_FILE"
        cat "$file" >> "$OUTPUT_FILE"
        echo -e "\n" >> "$OUTPUT_FILE"
    fi
done

# Capture contents of _pages directory
print_separator "_pages directory"
for file in _pages/*.md; do
    if [ -f "$file" ]; then
        echo "File: $file" >> "$OUTPUT_FILE"
        cat "$file" >> "$OUTPUT_FILE"
        echo -e "\n" >> "$OUTPUT_FILE"
    fi
done

# Capture custom CSS
print_separator "Custom CSS"
if [ -f assets/css/main.scss ]; then
    cat assets/css/main.scss >> "$OUTPUT_FILE"
elif [ -f assets/css/style.scss ]; then
    cat assets/css/style.scss >> "$OUTPUT_FILE"
else
    echo "No custom CSS file found" >> "$OUTPUT_FILE"
fi

echo "Site contents have been captured in $OUTPUT_FILE"
