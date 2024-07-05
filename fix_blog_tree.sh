#!/bin/bash

# Backup the current site
timestamp=$(date +"%Y%m%d_%H%M%S")
backup_dir="../johnbartlett.github.io_backup_$timestamp"
mkdir -p "$backup_dir"
cp -R * "$backup_dir"

echo "Backup created in $backup_dir"

# Update _config.yml to ensure category and tag archives are set up correctly
cat >> _config.yml << EOL

# Archives
category_archive:
  type: jekyll-archives
  path: /categories/
tag_archive:
  type: jekyll-archives
  path: /tags/
jekyll-archives:
  enabled:
    - categories
    - tags
  layouts:
    category: archive-taxonomy
    tag: archive-taxonomy
  permalinks:
    category: /categories/:name/
    tag: /tags/:name/
EOL

# Update the blog-tree.md file
cat > _pages/blog-tree.md << EOL
---
title: "Blog Categories"
layout: categories
permalink: /blog-tree/
author_profile: true
---

Here's a list of all the categories on this blog:

{% for category in site.categories %}
  <h2>{{ category[0] }}</h2>
  <ul>
    {% for post in category[1] %}
      <li><a href="{{ post.url }}">{{ post.title }}</a></li>
    {% endfor %}
  </ul>
{% endfor %}
EOL

# Ensure all blog posts have proper front matter with categories
for file in _posts/*.md; do
    if ! grep -q "categories:" "$file"; then
        sed -i '' '1r /dev/stdin' "$file" << EOL

categories:
  - Blog
EOL
    fi
done

# Update navigation to ensure blog tree link is correct
sed -i '' 's/url: \/blog-tree\//url: \/categories\//' _data/navigation.yml

# Add jekyll-archives to the plugins in _config.yml if not already present
if ! grep -q "jekyll-archives" _config.yml; then
    sed -i '' '/plugins:/a\  - jekyll-archives' _config.yml
fi

# Commit changes
git add .
git commit -m "Fix blog tree and category issues"

echo "Changes have been made and committed. Please review the changes and push to your repository if satisfied."
echo "To roll back changes, restore from the backup directory: $backup_dir"
