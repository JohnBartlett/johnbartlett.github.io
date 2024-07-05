#!/bin/bash

# --- Configuration ---
POSTS_DIR="_posts"
POST_FILENAME=$(date +"%Y-%m-%d-generative-ai-post.md") 
POST_TITLE="New Developments in Generative AI"

# --- Functions ---
create_new_post() {
  cat > "$POSTS_DIR/$POST_FILENAME" <<EOL
---
title: "$POST_TITLE"
date: $(date +'%Y-%m-%d %H:%M:%S %z')
categories:
  - generative ai
tags:
  - AI
  - Generative AI
---

Generative AI is rapidly evolving, with new models and applications emerging constantly. This post explores some of the latest advancements and their potential impact.

## Key Developments:

* **Improved Image Generation:**  Recent models can produce incredibly realistic and detailed images from text descriptions.
* **Enhanced Text Generation:**  The quality and coherence of AI-generated text are continuously improving, making it useful for various tasks.
* **Creative Applications:** Generative AI is being used for music composition, video generation, and even creating virtual worlds.

## Potential Impact:

The advancements in generative AI have the potential to revolutionize industries like:

* **Content creation:**  Automating the generation of marketing materials, articles, and other types of content.
* **Design:**  Aiding designers in generating creative ideas and concepts.
* **Entertainment:**  Creating new forms of interactive and immersive experiences.

## Ethical Considerations:

While the potential of generative AI is exciting, it's important to consider the ethical implications, such as:

* **Misinformation:**  The potential for AI-generated content to be used for spreading misinformation.
* **Bias:**  The risk of AI models perpetuating biases present in training data.
* **Job Displacement:**  The possibility of AI automating jobs that are currently done by humans.

It's crucial to address these concerns proactively to ensure that generative AI is developed and used responsibly.

## Conclusion:

Generative AI is a rapidly advancing field with immense potential. As we continue to explore its capabilities, it's essential to navigate the ethical challenges and ensure that this technology is harnessed for the betterment of society.
EOL

  echo "New post created: $POST_FILENAME"
}

build_and_deploy() {
    echo "Installing dependencies..."
    bundle install

    echo "Building site..."
    bundle exec jekyll build

    echo "Deploying to GitHub Pages..."
    git add .
    git commit -m "Add new generative ai post and rebuild website"
    git push origin main 
    echo "Deployment complete. Changes may take a few minutes to appear on your site."
}

# --- Main Script ---
create_new_post
build_and_deploy

