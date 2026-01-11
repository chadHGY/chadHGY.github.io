# Agent Guide for al-folio Jekyll Site

This document provides essential information for AI coding agents working on this al-folio-based Jekyll academic website.

## Project Overview

- **Framework**: Jekyll static site generator
- **Theme**: al-folio (academic portfolio theme)
- **Language**: Ruby (Jekyll plugins), JavaScript (frontend), SCSS (styling), Liquid (templating)
- **Deployment**: GitHub Pages via GitHub Actions
- **URL**: https://chadhgy.github.io

### Repository Architecture
- **Source Repo (Private)**: `chadHGY/chadHGY.github.io.source`
  - Contains source code, configuration, and build workflows.
- **Public Site Repo (Public)**: `chadHGY/chadHGY.github.io`
  - Contains only the generated static site (`_site`) served by GitHub Pages.

## Build & Development Commands

### Local Development

#### Prerequisites (First Time Setup)
```bash
# Install Ruby dependencies
bundle install

# Install Python dependencies (for Jupyter notebook support)
pip3 install -r requirements.txt
```

**Note**: In the devcontainer, these dependencies are installed automatically via `.devcontainer/post-create.sh`.

#### Running Local Development Server

**Simple command (recommended for testing)**:
```bash
bundle exec jekyll serve --trace
# Site will be available at http://localhost:4000
```

**Full development command (with live reload)**:
```bash
bundle exec jekyll serve --watch --port=8080 --host=0.0.0.0 --livereload --verbose --trace --force_polling
# Site will be available at http://localhost:8080
```

**Using Makefile**:
```bash
make run_server
```

**Using Docker Compose** (if not already in container):
```bash
docker compose pull
docker compose up
```

#### Build for Production

```bash
# Full production build with LSI (Latent Semantic Indexing for related posts)
JEKYLL_ENV=production bundle exec jekyll build --lsi

# Build with CSS purging (production)
bundle exec jekyll build --lsi
purgecss -c purgecss.config.js
```

### Command Options Explained

- `--trace`: Shows full stack trace on errors (useful for debugging)
- `--watch`: Auto-regenerates site when files change
- `--livereload`: Auto-refreshes browser on changes
- `--port=8080`: Changes port (default is 4000)
- `--host=0.0.0.0`: Makes server accessible from outside container
- `--force_polling`: Use polling instead of filesystem events (better in containers)
- `--lsi`: Enable Latent Semantic Indexing for better related posts (slower)

### Important Notes

- **`jekyll serve` automatically builds** the site before serving (no separate `build` command needed)
- Changes to `_config.yml` require server restart
- Press `Ctrl+C` to stop the server
- Build time: ~4-5 seconds on first run

### Port Configuration
- Default port: `4000` (Jekyll default)
- Docker port: `8080` (configured in docker-compose.yml)
- Edit `docker-compose.yml` to change port mapping

### Testing

This project does not have automated tests. Manual testing involves:
1. Start server: `bundle exec jekyll serve --trace`
2. Check console output for build errors
3. Access site at `http://localhost:4000` (or 8080 in Docker)
4. Verify pages render correctly in browser
5. Check for broken links or missing assets
6. Test navigation and interactive features

## Project Structure

```
.
├── _config.yml           # Main site configuration
├── _pages/              # Markdown pages (about, publications, etc.)
├── _posts/              # Blog posts
├── _projects/           # Project entries
├── _news/               # News/announcements
├── _bibliography/       # BibTeX files for publications
├── _layouts/            # HTML layouts (Liquid templates)
├── _includes/           # Reusable HTML components
├── _sass/               # SCSS stylesheets
├── _plugins/            # Custom Jekyll Ruby plugins
├── assets/              # Static assets (images, JS, CSS)
├── Gemfile              # Ruby dependencies
└── _site/               # Generated static site (gitignored)
```

## Code Style Guidelines

### Ruby (Jekyll Plugins)

**Conventions:**
- Use 4-space indentation
- Class names: `CamelCase`
- Method names: `snake_case`
- Module structure: Wrap plugins in `Jekyll` module
- Register filters/tags at end of file

**Example Structure:**
```ruby
module Jekyll
    module MyFeature
        class MyClass
            def initialize(param:, optional: nil)
                self.param = param
            end

            def process!
                # implementation
            end

            private

            def helper_method
                # private methods
            end
        end
    end
end

Liquid::Template.register_filter(Jekyll::MyFeature)
```

### SCSS Styling

**Conventions:**
- Use 2-space indentation
- Use CSS variables: `var(--global-theme-color)`
- Nest selectors for clarity
- Comment major sections with banner comments
- Variables defined in `_sass/_variables.scss`
- Theme colors in `_sass/_themes.scss`

**Example:**
```scss
/*******************************************************************************
 * Section Name
 ******************************************************************************/

.my-component {
  color: var(--global-text-color);
  
  &:hover {
    color: var(--global-theme-color);
  }
  
  .child-element {
    padding: 1rem;
  }
}
```

### Markdown (Pages/Posts)

**Front Matter:**
- Always include YAML front matter
- Required fields: `layout`, `title`, `permalink`
- Use boolean flags: `news: true`, `social: false`

**Example:**
```markdown
---
layout: page
title: Page Title
permalink: /url-path/
description: Optional description
nav: true
nav_order: 1
---

Content goes here...
```

### Liquid Templates

**Conventions:**
- Use `{% %}` for logic, `{{ }}` for output
- Check existence before accessing: `{% if site.data.foo %}`
- Use meaningful variable names
- Comment complex logic

### JavaScript

**Conventions:**
- Use ES6+ syntax where supported
- Place custom scripts in `assets/js/`
- Use meaningful function names
- Add comments for complex logic

## Configuration

### Main Config File: `_config.yml`

Key sections:
- **Site settings**: title, email, description, url, baseurl
- **Collections**: news, projects
- **Plugins**: Listed under `plugins:` section
- **Scholar**: BibTeX bibliography settings
- **Features**: Enable/disable features (analytics, darkmode, etc.)

### Important Settings

- `url`: Base URL (e.g., https://chadhgy.github.io)
- `baseurl`: Subpath (empty for user sites, /repo-name for project sites)
- `scholar.last_name` / `scholar.first_name`: Used to identify your publications

## Publications System

- BibTeX files in `_bibliography/`
- Main file: `_bibliography/papers.bib`
- Custom BibTeX keywords: `abbr`, `abstract`, `pdf`, `code`, `website`, `selected`
- Rendered using `jekyll-scholar` plugin

## Common Tasks

### Adding a New Page

1. Create `_pages/mypage.md`
2. Add front matter with `layout`, `title`, `permalink`
3. Set `nav: true` to show in navigation
4. Write content in Markdown

### Adding a Blog Post

1. Create `_posts/YYYY-MM-DD-title.md`
2. Add front matter with `layout: post`, `title`, `date`
3. Write content in Markdown

### Adding a News Item

1. Create `_news/announcement_N.md`
2. Add front matter: `layout: post`, `date`, `inline: true/false`
3. Write announcement

### Modifying Styles

1. Edit files in `_sass/`
2. Main file: `_sass/_base.scss`
3. Variables: `_sass/_variables.scss`
4. Themes: `_sass/_themes.scss`

### Adding a Jekyll Plugin

1. Create `.rb` file in `_plugins/`
2. Wrap in `Jekyll` module
3. Register with Liquid: `Liquid::Template.register_filter()`

## Important Notes for Agents

1. **Never modify `_site/`**: This directory is auto-generated
2. **Config changes require rebuild**: Changes to `_config.yml` need server restart
3. **BibTeX is processed**: Don't manually edit publication HTML
4. **Images**: Place in `assets/img/`, responsive formats auto-generated
5. **Liquid syntax**: Use `target="\_blank"` (escaped) in Markdown
6. **Git workflow**: Default branch is `master` or `main`
7. **Deployment**: GitHub Actions auto-deploys on push to main/master
8. **NEVER automatic commit or push**: Only commit/push when explicitly requested by the user. Always ask for confirmation before any git operations that modify history or push to remote.
9. **Commit Messages**: Use Conventional Commits format (e.g., `feat: add blog post`, `fix: correct typo in footer`, `chore: update dependencies`).

## Deployment Pipeline

The `.github/workflows/deploy.yml` workflow:
1. Checks out code
2. Sets up Ruby 3.2.2
3. Installs dependencies (imagemagick, jekyll, etc.)
4. Builds site with `bundle exec jekyll build` (NOTE: `--lsi` disabled temporarily)
5. Purges unused CSS
6. Deploys to the `master` branch of the public repository (`chadHGY/chadHGY.github.io`)

## Future TODOs

- **Re-enable LSI**: The `--lsi` flag was removed from the build command in `.github/workflows/deploy.yml` to prevent "zero vectors" errors on a new blog. Re-enable it (`bundle exec jekyll build --lsi`) once the blog has 10-20 substantial posts to improve "Related Posts" accuracy.

## Common Pitfalls

- **Build failures**: Check for syntax errors in Liquid templates
- **Broken links**: Ensure proper `baseurl` configuration
- **Missing dependencies**: Run `bundle install` after Gemfile changes
- **Plugin errors**: Verify plugin registration at end of .rb files
- **CSS not updating**: Clear browser cache or check CSS purge config

## Resources

- Jekyll Documentation: https://jekyllrb.com/docs/
- al-folio Repository: https://github.com/alshedivat/al-folio
- Liquid Syntax: https://shopify.github.io/liquid/
- Jekyll Scholar: https://github.com/inukshuk/jekyll-scholar
