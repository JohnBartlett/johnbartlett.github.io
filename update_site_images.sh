#!/bin/bash

# Define paths
OLD_IMAGES_DIR="../johnbartlett.github.io_backup_20240704_105253/assets/images"
CURRENT_IMAGES_DIR="/Users/john/johnbartlett.github.io/assets/images"
FAVICON_SOURCE="$OLD_IMAGES_DIR/favicon.ico"
FAVICON_DEST="/Users/john/johnbartlett.github.io"

# Check if favicon.ico exists before copying
if [ -f "$FAVICON_SOURCE" ]; then
    cp "$FAVICON_SOURCE" "$FAVICON_DEST"
    echo "Favicon copied successfully."
else
    echo "Favicon not found at: $FAVICON_SOURCE"
fi

# Check if current images directory exists
if [ -d "$CURRENT_IMAGES_DIR" ]; then
    # Move all images from old directory to current images directory
    mv "$OLD_IMAGES_DIR"/* "$CURRENT_IMAGES_DIR"
    echo "Images moved successfully."
else
    echo "Current images directory not found at: $CURRENT_IMAGES_DIR"
fi
