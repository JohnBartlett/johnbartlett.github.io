import os
from datetime import datetime

# List of orphaned categories
categories = [
    "thoughts", "generative-ai", "ml", "photos", "philosophy",
    "quantum-cryptography", "llms", "quantum", "travels",
    "ai-strategy", "new-ai"
]

# Directory where category pages will be created
categories_dir = "categories"

# Ensure the categories directory exists
os.makedirs(categories_dir, exist_ok=True)

# Current date for the file
current_date = datetime.now().strftime("%Y-%m-%d")

for category in categories:
    # Create a filename for the category index
    filename = f"{category}.md"
    filepath = os.path.join(categories_dir, filename)
    
    # Create the content for the category index
    content = f"""---
layout: category
title: "{category.replace('-', ' ').title()}"
category: {category}
---

This is the index page for the {category.replace('-', ' ').title()} category.

"""
    
    # Write the content to the file
    with open(filepath, "w") as f:
        f.write(content)
    
    print(f"Created category index for {category} at {filepath}")

print("All category index pages have been created.")
