# fni-docs-theme

Forked from [just-the-docs](https://pmarsceill.github.io/just-the-docs/)

Pertinent differences:
* Nav generation has been moved to a plugin, lib/generators/nav-generator. This ensures the nav is only generated once and can be included 

## Installation

This theme is distributed as a Jekyll plugin, to install:

* Add the plugin to your gemfile (recommend pinning a specific version):
```ruby
group :jekyll_plugins do
  gem "fni-docs-theme", "0.4.2"
end
```

Add these lines to your Jekyll site's `_config.yml`:

```yaml
theme: fni-docs-theme

plugins:
  - fni-docs-theme
```

## Usage

[View the documentation](https://pmarsceill.github.io/just-the-docs/) for usage information.

## Local Testing

```bash
> ./serve
```

Access the site at http://localhost:4000/fni-docs-theme/

## Publishing

This theme/plugin is published as fni-docs-theme to rubygems.org.

## License

The theme is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
