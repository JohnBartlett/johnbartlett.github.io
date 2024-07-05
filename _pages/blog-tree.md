---
title: "Blog Categories"
layout: categories
permalink: /categories/
author_profile: true
---

Here's a list of all the categories on this blog:

{% for category in site.categories %}
  <h2><a href="{{ site.baseurl }}/categories/{{ category[0] | slugify }}">{{ category[0] }}</a></h2>
  <ul>
    {% for post in category[1] %}
      <li><a href="{{ post.url | relative_url }}">{{ post.title }}</a></li>
    {% endfor %}
  </ul>
{% endfor %}
