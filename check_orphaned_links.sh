#!/bin/bash

# Create a virtual environment if it doesn't exist
if [ ! -d "venv" ]; then
    python3 -m venv venv
fi

# Activate the virtual environment
source venv/bin/activate

# Install required packages
pip install requests beautifulsoup4

# Run the Python script
python check_orphaned_links.py

# Deactivate the virtual environment
deactivate
