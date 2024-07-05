#!/bin/bash

# Define paths
SITE_DIR="$HOME/johnbartlett.github.io"
GEMFILE="$SITE_DIR/Gemfile"
CONFIG_FILE="$SITE_DIR/_config.yml"
INCLUDES_DIR="$SITE_DIR/_includes"

# Function to check if a gem is installed
check_gem_installed() {
    local gem_name="$1"
    if ! bundle list | grep -q "$gem_name"; then
        echo "$gem_name is not installed. Installing now..."
        bundle add "$gem_name"
    else
        echo "$gem_name is installed."
    fi
}

# Function to verify the Jekyll build
verify_jekyll_build() {
    echo "Building the Jekyll site to check for errors..."
    bundle exec jekyll build
    if [ $? -eq 0 ]; then
        echo "Jekyll site built successfully."
    else
        echo "Error encountered during Jekyll build. Please check the output for details."
        return 1
    fi
}

# Function to check the plugin in the config file
check_plugin_in_config() {
    local plugin_name="$1"
    echo "Checking if $plugin_name is enabled in the config file..."
    grep -q "jekyll-include-cache" "$CONFIG_FILE"
    if [ $? -eq 0 ]; then
        echo "$plugin_name is enabled in the config file."
    else
        echo "$plugin_name is not found in the config file. Adding it..."
        echo "plugins:" >> "$CONFIG_FILE"
        echo "  - jekyll-include-cache" >> "$CONFIG_FILE"
    fi
}

# Ensure running in the site directory
cd "$SITE_DIR"

# Ensure Gemfile exists
if [ -f "$GEMFILE" ]; then
    echo "Gemfile found."
else
    echo "Gemfile does not exist. Exiting..."
    exit 1
fi

# Check if 'jekyll-include-cache' is installed
check_gem_installed "jekyll-include-cache"

# Check if 'jekyll-include-cache' is in the config file
check_plugin_in_config "jekyll-include-cache"

# Attempt to build the Jekyll site
verify_jekyll_build

echo "All checks completed."
