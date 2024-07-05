#!/bin/bash

# Variables
REPO_DIR="/Users/john/johnbartlett.github.io"
BACKUP_DIR="$HOME/backup_github"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_REPO="$BACKUP_DIR/johnbartlett.github.io.backup_$TIMESTAMP"
TEMP_REPO_DIR="$HOME/temp_johnbartlett.github.io"
SENSITIVE_FILE="fix_blog_links.sh"
REMOTE_URL="https://github.com/JohnBartlett/johnbartlett.github.io.git"

# Create backup directory if it doesn't exist
mkdir -p $BACKUP_DIR

# Backup the repository
echo "Creating backup of the repository..."
git clone --mirror $REPO_DIR $BACKUP_REPO

# Check if the backup was successful
if [ $? -ne 0 ]; then
    echo "Backup failed. Exiting..."
    exit 1
fi

echo "Backup created at $BACKUP_REPO"

# Ensure git-filter-repo is installed
if ! command -v git-filter-repo &> /dev/null; then
    echo "git-filter-repo is not installed. Installing..."
    pip install git-filter-repo
fi

# Remove existing temporary repository directory if it exists
if [ -d "$TEMP_REPO_DIR" ]; then
    echo "Removing existing temporary repository directory..."
    rm -rf $TEMP_REPO_DIR
fi

# Clone the repository again to a temporary location
echo "Cloning the repository to a temporary location..."
git clone --no-local $REPO_DIR $TEMP_REPO_DIR

# Check if the clone was successful
if [ $? -ne 0 ]; then
    echo "Cloning failed. Exiting..."
    exit 1
fi

# Navigate to the temporary repository
cd $TEMP_REPO_DIR

# Remove the sensitive file from the commit history
echo "Removing $SENSITIVE_FILE from commit history..."
git filter-repo --path $SENSITIVE_FILE --invert-paths

# Check if the filter-repo command was successful
if [ $? -ne 0 ]; then
    echo "Failed to remove $SENSITIVE_FILE from commit history. Exiting..."
    exit 1
fi

echo "Sensitive file removed from commit history."

# Add the remote origin
git remote add origin $REMOTE_URL

# Force push the changes to the repository
echo "Force pushing changes to the repository..."
git push origin --force --all

# Check if the push was successful
if [ $? -ne 0 ]; then
    echo "Failed to push changes to the repository. Exiting..."
    exit 1
fi

echo "Changes pushed successfully."

# Clean up the temporary repository
echo "Cleaning up..."
rm -rf $TEMP_REPO_DIR

echo "Process completed."
