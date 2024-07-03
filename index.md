---
layout: home
author_profile: true
---

# Welcome to John Bartlett's AI Consulting

Specializing in cutting-edge AI solutions for businesses. With years of experience in machine learning and data science, I help companies leverage the power of AI to drive innovation and efficiency.

## Services
- AI Strategy Development
- Machine Learning Implementation
- Data Science Consulting
- AI Training and Workshops

## Recent Posts

{% for post in site.posts limit:5 %}
  <h3><a href="{{ post.url }}">{{ post.title }}</a></h3>
  <p>{{ post.date | date: "%B %d, %Y" }}</p>
  {{ post.excerpt }}
{% endfor %}
