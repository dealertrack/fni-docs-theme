# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is `fni-docs-theme`, a Jekyll theme forked from just-the-docs. It's distributed as both a Jekyll theme and Ruby gem for documentation sites.

## Key Commands

### Development & Testing
```bash
./serve                    # Start local development server (http://localhost:4000/fni-docs-theme/)
npm test                   # Run stylelint on all SCSS files
npm run format             # Format SCSS, JS, JSON files with Prettier
npm run stylelint-check    # Check stylelint configuration
```

### Publishing
- Bump version in `fni-docs-theme.gemspec`
- Run "Publish Gem" GitHub Action

## Architecture

### Core Components

**Navigation System**: Custom navigation generation moved to a Jekyll plugin (`lib/generators/nav-generator.rb`) that builds hierarchical navigation based on page frontmatter (`parent`, `grand_parent`, `nav_order`, `has_children`). The generator runs once and attaches nav data to the default layout, also creating breadcrumb data.

**PlantUML Integration**: Custom converter (`lib/converters/plantuml-converter.rb`) processes `.iuml` files into SVG diagrams via external PlantUML server. Automatically adds themes and styling for dark mode compatibility.

### File Structure

- `_sass/`: SCSS stylesheets including color schemes (dark/light), utilities, and component styles
- `_layouts/`: Jekyll layout templates (default, page, post, home, etc.)
- `_includes/`: Reusable template components (nav, head, footer, etc.)
- `lib/`: Ruby plugins and generators
- `assets/`: Static assets including JavaScript (lunr.min.js for search)

### Theme Features

- Responsive design with mobile navigation
- Built-in search functionality using Lunr.js
- Dark/light color scheme support
- Hierarchical navigation with breadcrumbs
- PlantUML diagram rendering
- GitHub integration (edit links, last modified timestamps)
- Custom styling based on Primer CSS

### Configuration

Theme behavior controlled via `_config.yml` with settings for:
- Search configuration (heading levels, previews, tokenization)
- Navigation sorting and auxiliary links
- GitHub integration settings
- Color scheme selection
- Footer customization

The theme expects pages to use frontmatter fields like `parent`, `nav_order`, `has_children`, and `nav_exclude` for navigation structure.