#!/bin/bash

# Directory paths
PROJECT_DIR="/Users/john/johnbartlett.github.io"
POSTS_DIR="$PROJECT_DIR/_posts"
CONFIG_FILE="$PROJECT_DIR/_config.yml"
SITE_DIR="$PROJECT_DIR/_site"

# Ensure _config.yml has the correct settings
echo "Updating _config.yml..."
cat > $CONFIG_FILE <<EOL
baseurl: "" # the subpath of your site, e.g. /blog
url: "https://johnbartlett.github.io" # the base hostname & protocol for your site
permalink: /:categories/:year/:month/:day/:title/
theme: minimal-mistakes-jekyll
EOL

# Verify and update permalinks in posts
echo "Updating permalinks in posts..."
for post in $POSTS_DIR/*.md; do
    # Extract title and date from the file
    title=$(yq e '.title' "$post" | sed 's/ /-/g' | tr '[:upper:]' '[:lower:]')
    date=$(yq e '.date' "$post" | cut -d' ' -f1)
    year=$(echo $date | cut -d'-' -f1)
    month=$(echo $date | cut -d'-' -f2)
    day=$(echo $date | cut -d'-' -f3)
    categories=$(yq e '.categories' "$post" | sed 's/ /-/g' | tr '[:upper:]' '[:lower:]' | tr '\n' ' ' | sed 's/ $//')

    # Update permalink in the post front matter
    yq e -i ".permalink = \"/$categories/$year/$month/$day/$title/\"" "$post"
    echo "Updated permalink in $post"
done

# Verify files are in the correct directory
echo "Verifying file structure..."
if [ ! -d "$POSTS_DIR" ]; then
    echo "Error: _posts directory not found."
    exit 1
fi

# Ensure required gems are installed
echo "Ensuring required gems are installed..."
cd $PROJECT_DIR
bundle install

# Set GitHub API token

# Regenerate the site
echo "Regenerating the site..."
bundle exec jekyll build

# Check all links with htmlproofer
echo "Checking links with htmlproofer..."
#bundle exec htmlproofer ./_site --disable-external --url-ignore "/#main"
#bundle exec htmlproofer ./_site --disable-external --url-ignore-pattern "/#main"
bundle exec htmlproofer ./_site --disable-external --ignore-urls "/#main"

# If htmlproofer returns an error, stop the script
if [ $? -ne 0 ]; then
    echo "htmlproofer found issues with the site. Please fix them before proceeding."
    exit 1
fi

# Push changes to GitHub
echo "Pushing changes to GitHub..."
git add _config.yml $POSTS_DIR/*.md
git commit -m "Fix permalink issues and update _config.yml"
git push origin main

echo "Site regeneration and push complete. Check your GitHub Pages for updates."
