#!/bin/bash

# Create _posts directory if it doesn't exist
mkdir -p _posts

# Function to create a blog post
create_post() {
    local date=$1
    local title=$2
    local categories=$3
    local tags=$4
    local content=$5
    
    local filename="_posts/${date}-${title// /-}.md"
    echo "---
title: \"$title\"
date: $date
categories:
$categories
tags:
$tags
---

$content

[Rest of the blog post content]" > "$filename"
    
    echo "Created $filename"
}

# Create sample blog posts
create_post "2023-06-28" "The Revolution of Generative AI in Content Creation" \
"  - AI
  - Generative AI" \
"  - AI
  - Generative AI
  - Content Creation" \
"Generative AI is transforming how we create content across various industries..."

create_post "2023-06-29" "Emerging Trends in AI: What to Watch in 2023" \
"  - AI
  - New AI" \
"  - AI
  - Trends
  - Innovation" \
"As we move further into 2023, several exciting trends are shaping the AI landscape..."

create_post "2023-06-30" "Developing a Robust AI Strategy for Your Business" \
"  - AI
  - AI Strategy" \
"  - AI
  - Business Strategy
  - Digital Transformation" \
"In today's rapidly evolving technological landscape, having a solid AI strategy is crucial for businesses..."

create_post "2023-07-01" "Understanding Large Language Models: Capabilities and Limitations" \
"  - AI
  - LLMs" \
"  - AI
  - Language Models
  - Natural Language Processing" \
"Large Language Models (LLMs) have become a cornerstone of modern AI applications..."

create_post "2023-07-02" "Demystifying Machine Learning: A Beginner's Guide" \
"  - Machine Learning" \
"  - ML
  - AI
  - Data Science" \
"Machine Learning is often seen as a complex field, but at its core, it's about teaching computers to learn from data..."

create_post "2023-07-03" "Quantum Computing: The Next Frontier in Computational Power" \
"  - Quantum Computing" \
"  - Quantum
  - Computing
  - Technology" \
"Quantum computing promises to revolutionize our approach to solving complex problems..."

create_post "2023-07-04" "The Promise of Quantum Cryptography in Cybersecurity" \
"  - Cryptography
  - Quantum Cryptography" \
"  - Quantum
  - Cybersecurity
  - Encryption" \
"As quantum computing advances, so does the field of quantum cryptography..."

create_post "2023-07-05" "AI Conferences Around the World: A Personal Journey" \
"  - Personal
  - Travels" \
"  - Conferences
  - AI
  - Professional Development" \
"Over the past year, I've had the opportunity to attend AI conferences across the globe..."

echo "All sample blog posts have been created."

# Git commands to add, commit, and push changes
git add _posts/*
git commit -m "Add sample blog posts across various categories"
git push origin clean-slate

echo "Changes have been committed and pushed to the clean-slate branch."
