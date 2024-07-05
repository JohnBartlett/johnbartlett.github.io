#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_color() {
    color=$1
    message=$2
    echo -e "${color}${message}${NC}"
}

# Check if a directory exists
check_directory() {
    if [ -d "$1" ]; then
        print_color $GREEN "✓ $1 directory exists"
    else
        print_color $RED "✗ $1 directory is missing"
    fi
}

# Check if a file exists
check_file() {
    if [ -f "$1" ]; then
        print_color $GREEN "✓ $1 file exists"
    else
        print_color $RED "✗ $1 file is missing"
    fi
}

# Check directory structure
print_color $YELLOW "Checking directory structure:"
check_directory "_posts"
check_directory "_pages"
check_directory "assets"
check_directory "assets/css"
check_directory "_data"

# Check key files
print_color $YELLOW "\nChecking key files:"
check_file "_config.yml"
check_file "_data/navigation.yml"
check_file "index.md"
check_file "assets/css/custom.scss"

# Check _config.yml content
print_color $YELLOW "\nChecking _config.yml content:"
if grep -q "remote_theme: \"mmistakes/minimal-mistakes" "_config.yml"; then
    print_color $GREEN "✓ remote_theme is set correctly"
else
    print_color $RED "✗ remote_theme is missing or incorrect"
fi

# Check navigation.yml structure
print_color $YELLOW "\nChecking navigation.yml structure:"
if grep -q "main:" "_data/navigation.yml" && grep -q "title:" "_data/navigation.yml" && grep -q "url:" "_data/navigation.yml"; then
    print_color $GREEN "✓ navigation.yml has correct structure"
else
    print_color $RED "✗ navigation.yml is missing key elements"
fi

# Check posts
print_color $YELLOW "\nChecking posts:"
post_count=$(ls -1 _posts/*.md 2>/dev/null | wc -l)
if [ $post_count -gt 0 ]; then
    print_color $GREEN "✓ Found $post_count posts"
    
    for post in _posts/*.md; do
        # Check post filename format
        if [[ $post =~ ^_posts/[0-9]{4}-[0-9]{2}-[0-9]{2}-.*\.md$ ]]; then
            print_color $GREEN "✓ $post has correct filename format"
        else
            print_color $RED "✗ $post has incorrect filename format"
        fi
        
        # Check post front matter
        if grep -q "^---$" "$post" && grep -q "^title:" "$post" && grep -q "^date:" "$post" && grep -q "^categories:" "$post"; then
            print_color $GREEN "✓ $post has correct front matter"
        else
            print_color $RED "✗ $post is missing required front matter"
        fi
    done
else
    print_color $RED "✗ No posts found in _posts directory"
fi

# Check for placeholder images
print_color $YELLOW "\nChecking for placeholder images:"
if [ -f "assets/images/logo.png" ]; then
    print_color $GREEN "✓ logo.png exists"
else
    print_color $YELLOW "! logo.png is missing. Make sure to add your logo."
fi

if [ -f "assets/images/profile.jpg" ]; then
    print_color $GREEN "✓ profile.jpg exists"
else
    print_color $YELLOW "! profile.jpg is missing. Make sure to add your profile picture."
fi

print_color $YELLOW "\nTest completed. Review any errors or warnings above."
