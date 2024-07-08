#!/bin/bash

# Script to commit and push changes to GitHub repository

# Commit message
COMMIT_MESSAGE="Update website content"

# Commit changes
git add .
git commit -m "$COMMIT_MESSAGE"

# Push changes to GitHub
git push origin main

# Check if push was successful
if [ $? -eq 0 ]; then
    echo "Successfully pushed changes to GitHub."
else
    echo "Failed to push changes to GitHub. Please check any errors."
fi
