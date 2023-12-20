source 'https://rubygems.org'

gem "jekyll", "~> 4.2"

gem "jekyll-theme-primer", "~> 0.6" # Theme

group :production, :jekyll_plugins do
  #gem "jekyll-remote-theme", "~> 0.4" # to use GitHub-hosted themes

  ## primer dependencies
  gem "jekyll-github-metadata", "~> 2.15" # GitHub metadata
  gem "jekyll-seo-tag", "~> 2.8" # Site metadata

  ## Markdown converter for GitHub Flavored Markdown
  # gem "jekyll-commonmark-ghpages", "~> 2.0"

  gem "jekyll-feed", "~> 0.16" # RSS Atom feed
  gem "jekyll-sitemap", "~> 1.4" # XML sitemap

  gem "jekyll-titles-from-headings", "~> 0.5" # Page title

  # gem "jekyll-paginate", "~> 1.1" # Pagination
  gem "jekyll-paginate-v2", "~> 3.0"

  gem "jekyll-default-layout", "~> 0.1" # Automatically sets layout

  gem "jekyll-relative-links", "~> 0.6" # Relative links to markdown file
  gem "jekyll-redirect-from", "~> 0.16" # Redirection from another posts

  # gem "jekyll-readme-index", "~> 0.3" # README to index.html
  # gem "jekyll-optional-front-matter", "~> 0.3" # All markdown files convert to html

  # gem "jekyll-mentions" "~> 1.6" # `@mention` format

  gem "jekyll-octicons" # GitHub's icons tag
  # gem "jemoji", "~> 0.12" # GitHub's emoji codes
  # gem "jekyll-avatar", "~> 0.8" # GitHub user's avatar tag

  # gem "jekyll-gist", "~> 1.5" # Gist embeds tag

  # gem "jekyll-include-cache", "~> 0.2" # Cache of Liquid includes for build

  gem "jekyll-last-modified", "~> 1.0"
end

group :development, :test do
  gem "faraday-retry", "~> 2.0"
  gem 'dotenv', "~> 2.8"
  gem "webrick", "~> 1.7"
  gem "jekyll-compose", "~> 0.12"
end
