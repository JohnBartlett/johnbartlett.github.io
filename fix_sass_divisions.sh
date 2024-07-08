#!/bin/bash

# Directory where your compiled CSS files are located, relative to the script
css_dir="./_site/assets/css"

# Check if the directory exists
if [ -d "$css_dir" ]; then
  # Find all .css files recursively
  files=$(find "$css_dir" -name '*.css')

  # Loop through each file and perform replacements
  for file in $files
  do
    # Perform replacements for division outside of calc()
    if [[ -f "$file" ]]; then
      sed -i '' 's/\([0-9]*px\) \/ \([0-9]*\);/math.div(\1, \2);/g' "$file"
      sed -i '' 's/\(\$[a-zA-Z0-9_-]*\) \/ \([0-9]*px\)/math.div(\1, \2);/g' "$file"

      # Perform replacements for division inside calc()
      sed -i '' 's/calc(\([0-9]*px\) \/ \([0-9]*\))/calc(\1 \/ \2)/g' "$file"
      sed -i '' 's/calc(\(\$[a-zA-Z0-9_-]*\) \/ \([0-9]*px\))/calc(\1 \/ \2)/g' "$file"
    else
      echo "File $file does not exist."
    fi
  done

  echo "Replacement complete. Check your CSS files for changes."
else
  echo "Directory $css_dir does not exist."
fi
