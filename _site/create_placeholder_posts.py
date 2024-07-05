import os
from datetime import datetime

# List of orphaned categories
categories = [
    "new-ai", "llms", "ml", "quantum", "generative-ai", "thoughts",
    "travels", "photos", "ai-strategy", "philosophy", "quantum-cryptography"
]

# Directory where posts will be created
posts_dir = "_posts"

# Ensure the posts directory exists
os.makedirs(posts_dir, exist_ok=True)

# Current date for the post filename
current_date = datetime.now().strftime("%Y-%m-%d")

for category in categories:
    # Create a filename for the post
    filename = f"{current_date}-{category}-placeholder.md"
    filepath = os.path.join(posts_dir, filename)
    
    # Create the content for the post
    content = f"""---
layout: post
title: "{category.replace('-', ' ').title()} Placeholder"
date: {current_date}
categories: [{category}]
---

This is a placeholder post for the {category.replace('-', ' ').title()} category. More content will be added soon.

"""
    
    # Write the content to the file
    with open(filepath, "w") as f:
        f.write(content)
    
    print(f"Created placeholder post for {category} at {filepath}")

print("All placeholder posts have been created.")
