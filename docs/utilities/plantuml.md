---
layout: default
title: PlantUML
parent: Utilities
---

# PlantUML Diagrams
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## Embedding Diagrams

[PlantUML markup](https://plantuml.com/sequence-diagram) provides a means to describe intricate diagrams using a legible syntax. Having this as part of the documentation system allows these diagrams to sit close to the relevant page and be reviewed and accepted just like every other part of your documentation.

To encourage good organization, diagrams are authored in standalone files. From components/my-component.md, loading a diagram placed in components/my-component/my-diag.iuml would be:

`` {% raw  %}{% include iuml.html diagram="my-diag.iuml" %}{% endraw %} ``

Optionally with dimensions:

`` {% raw  %}{% include iuml.html diagram="my-diag.iuml" width=400 height=200 %}{% endraw %} ``

It is recommended to author these diagrams using VSCode. This IDE offers a PlantUML extension to make writing and previewing these diagrams a breeze.

The CI process renders all diagrams to SVG as the site is built, so they can also be linked to directly instead of using the embedded viewer:
`` [My Diagram](my-diag.svg) ``

Example:

{% include iuml.html diagram="sequence.iuml" %}

This viewer lets you click-and-drag to move around, use the mouse wheel to zoom and double-click to show full-screen.
