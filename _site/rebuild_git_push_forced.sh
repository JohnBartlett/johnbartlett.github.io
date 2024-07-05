#!/bin/bash

# --- Configuration ---
SITE_DIR="."  # Use the current directory as the website root

# --- Functions ---
build_and_deploy() {
  echo "Installing dependencies..."
  bundle install

  echo "Building site..."
  bundle exec jekyll build

  echo "Re-initializing Git repository..."
  rm -rf .git
  git init
  git add .
  git commit -m "Rebuild website from scratch"

  echo "Deploying to GitHub Pages..."
  git remote add origin https://github.com/JohnBartlett/johnbartlett.github.io.git
  git branch -M main
  git push -f origin main  # Force push to overwrite remote
  echo "Deployment complete. Changes may take a few minutes to appear on your site."
}

# --- Main Script ---
build_and_deploy

echo "Website rebuilt and deployed!"
