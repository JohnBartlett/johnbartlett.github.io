#!/bin/bash

# --- Configuration ---
BACKUP_DIR="../johnbartlett.github.io_backup_$(date +"%Y%m%d_%H%M%S")"
SITE_DIR="." # Set the site directory to the current directory.

# --- Functions ---
backup_site() {
  echo "Creating backup in $BACKUP_DIR..."
  mkdir -p "$BACKUP_DIR"
  cp -R "$SITE_DIR"/* "$BACKUP_DIR"  # Backup everything except hidden files (e.g., .git)
  echo "Backup complete."
}

clean_site() {
  echo "Cleaning existing site..."
  rm -rf "$SITE_DIR"/_site             # Remove the generated site
  find "$SITE_DIR" -mindepth 1 -type f ! -name "*.git*" -delete  # Delete files, excluding .git files and the script itself
  find "$SITE_DIR" -mindepth 1 -type d -empty -delete           # Delete empty directories
  echo "Clean complete."
}

# ... (rest of the functions: restore_from_backup, build_and_deploy remain the same)

# --- Main Script ---
# Change to the repository root before running any Git commands
cd "$SITE_DIR" || exit 1 # Exit if we can't change to the directory

backup_site
clean_site
restore_from_backup
build_and_deploy
