#!/bin/bash

# --- Configuration ---
POSTS_DIR="_posts"

# --- Functions ---
validate_yaml() {
  local file="$1"
  
  if ! yq eval '.' "$file" &> /dev/null; then  # Check YAML validity
    echo "Invalid YAML in $file:"
    yq eval '.' "$file"  # Print the file contents for manual inspection
  else
    echo "$file: YAML is valid"  # If valid, indicate so
  fi
}

# --- Main Script ---
echo "Validating YAML front matter in Jekyll posts..."

for file in "$POSTS_DIR"/*.md; do
  validate_yaml "$file"
done

echo "YAML validation complete."

