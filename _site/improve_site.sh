#!/bin/bash

# Create a backup of the current site
timestamp=$(date +"%Y%m%d_%H%M%S")
backup_dir="../johnbartlett.github.io_backup_$timestamp"
mkdir -p "$backup_dir"
cp -R * "$backup_dir"

echo "Backup created in $backup_dir"

# Update index.md to include more content and fix formatting
cat > index.md << EOL
---
layout: home
author_profile: true
header:
  overlay_color: "#000"
  overlay_filter: "0.5"
  overlay_image: /assets/images/ai-banner.jpg
  actions:
    - label: "Learn More"
      url: "/about/"
excerpt: "Innovative AI Solutions for Modern Businesses"
---

# Welcome to John Bartlett's AI Consulting

Specializing in cutting-edge AI solutions for businesses. With years of experience in machine learning and data science, I help companies leverage the power of AI to drive innovation and efficiency.

## Services

- AI Strategy Development
- Machine Learning Implementation
- Data Science Consulting
- AI Training and Workshops

## Featured Posts

{% for post in site.posts limit:3 %}
  <h3><a href="{{ post.url }}">{{ post.title }}</a></h3>
  <p>{{ post.date | date: "%B %d, %Y" }}</p>
  {{ post.excerpt }}
{% endfor %}

[View All Posts](/posts/){: .btn .btn--primary}
EOL

# Update _config.yml to include pagination for the home page
sed -i '' 's/paginate: 5 # amount of posts to show/paginate: 5 # amount of posts to show\npaginate_path: "\/page:num\/"/' _config.yml

# Update about.md with more detailed content
cat > _pages/about.md << EOL
---
title: "About John Bartlett"
permalink: /about/
---

# John Bartlett - AI Consultant

With over [X] years of experience in the field of Artificial Intelligence, I specialize in helping businesses leverage the power of AI to drive innovation and efficiency.

## Expertise

- Machine Learning
- Deep Learning
- Natural Language Processing
- Computer Vision
- AI Strategy Development

## Professional Background

[Provide a brief overview of your professional experience, notable projects, and achievements]

## Philosophy

[Share your approach to AI consulting and what sets you apart]

## Let's Connect

I'm always excited to discuss new AI projects and opportunities. Feel free to [contact me](/contact) to explore how we can work together to bring cutting-edge AI solutions to your business.
EOL

# Create a contact page
cat > _pages/contact.md << EOL
---
title: "Contact"
permalink: /contact/
---

# Get in Touch

I'm always interested in new AI projects and collaborations. Feel free to reach out to discuss how we can work together.

- **Email**: [your.email@example.com](mailto:your.email@example.com)
- **LinkedIn**: [Your LinkedIn Profile](https://www.linkedin.com/in/yourprofile/)
- **GitHub**: [Your GitHub Profile](https://github.com/JohnBartlett)

Or use the contact form below:

[Insert contact form here if your Jekyll theme supports it]
EOL

# Update navigation to include the contact page
sed -i '' '/tags:/a\
  - title: "Contact"\
    url: /contact/' _data/navigation.yml

# Commit changes
git add .
git commit -m "Improve site content and structure"

echo "Changes have been made and committed. Please review the changes and push to your repository if satisfied."
echo "To roll back changes, restore from the backup directory: $backup_dir"
