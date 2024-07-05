#!/bin/bash

# Function to check if a command exists
command_exists () {
    type "$1" &> /dev/null ;
}

# Check if git is installed
if ! command_exists git ; then
    echo "Git is not installed. Please install git and try again."
    exit 1
fi

# Check if Jekyll is installed
if ! command_exists jekyll ; then
    echo "Jekyll is not installed. Please install Jekyll and try again."
    exit 1
fi

# Create category index pages
python3 create_category_pages.py

# Git operations
git add .
git commit -m "Add category index pages"
git push origin main  # Change 'main' to your branch name if different

# Rebuild the site
jekyll build

# Run the orphaned links check
./check_orphaned_links.sh

# Check _config.yml for category pages
if grep -q "category_archive:" _config.yml; then
    echo "Category pages are enabled in _config.yml"
else
    echo "Warning: Category pages might not be enabled in _config.yml"
    echo "Please check and add the necessary configuration"
fi

# Reminder for manual checks
echo "Script completed. Please manually verify the following:"
echo "1. Check that your theme/templates include logic to display category pages"
echo "2. Ensure your site's permalink structure is set up to properly link to category pages"
echo "3. Rebuild and redeploy your site if necessary"
echo "4. Run the orphaned links check again after deployment to confirm all issues are resolved"
