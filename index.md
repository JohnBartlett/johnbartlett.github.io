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
excerpt: "Transforming businesses with cutting-edge AI solutions"
feature_row:
  - image_path: assets/images/ai-strategy.jpg
    alt: "AI Strategy"
    title: "AI Strategy Development"
    excerpt: "Crafting tailored AI strategies to drive your business forward."
  - image_path: assets/images/machine-learning.jpg
    alt: "Machine Learning"
    title: "Machine Learning Implementation"
    excerpt: "Leveraging state-of-the-art ML models for your specific needs."
  - image_path: assets/images/data-science.jpg
    alt: "Data Science"
    title: "Data Science Consulting"
    excerpt: "Unlocking the power of your data through advanced analytics."
---

{% include feature_row %}

## Latest Insights

Check out my latest thoughts on AI and its impact on business:

<div class="grid__wrapper">
  {% for post in site.posts limit:4 %}
    {% include archive-single.html type="grid" %}
  {% endfor %}
</div>
