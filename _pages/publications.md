---
layout: page
permalink: /publications/
title: publications
description: You can also find my articles on my <u><a href="https://scholar.google.com/citations?user=P9G_-kcAAAAJ" target="_blank" title="Google Scholar">Google Scholar profile</a>.</u>
years: [2020, 2019, 2018]
nav: true
---

<div class="publications">

{% for y in page.years %}
  <h2 class="year">{{y}}</h2>
  {% bibliography -f papers -q @*[year={{y}}]* %}
{% endfor %}

</div>
