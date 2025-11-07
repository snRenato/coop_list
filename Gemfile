source "https://rubygems.org"

# ----------------------------------------
# == CORE RAILS & WEB SERVER
# ----------------------------------------
gem "rails", "~> 8.0.3"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# ----------------------------------------
# == FRONTEND & ASSETS
# ----------------------------------------
# The modern asset pipeline for Rails [https://github.com/rails/propshaft]
gem "propshaft"

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

gem "tailwindcss-rails", "~> 4.3"

# ----------------------------------------
# == AUTHENTICATION & I18N
# ----------------------------------------
gem "devise"
gem "devise-i18n"
gem "pundit", "~> 2.5"
gem "rails-i18n", "~> 8.0.0" # For Rails >= 8.0.0

# ----------------------------------------
# == RAILS 8 "SOLID" GEMS
# ----------------------------------------
# Use the database-backed adapters for Rails.cache, Active Job, and Action Cable
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"

# ----------------------------------------
# == UTILITIES & DEPLOYMENT
# ----------------------------------------

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Deploy this application anywhere as a Docker container [https://kamal-deploy.org]
gem "kamal", require: false

# Add HTTP asset caching/compression and X-Sendfile acceleration to Puma [https://github.com/basecamp/thruster/]
gem "thruster", require: false

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"


# ----------------------------------------
# == DEVELOPMENT & TEST GROUP
# ----------------------------------------
group :development, :test do
  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem "brakeman", require: false

  # Omakase Ruby styling [https://github.com/rails/rubocop-rails-omakase/]
  gem "rubocop-rails-omakase", require: false

  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  # gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"

  # --- Core Testing Suite (Alphabetized) ---
  gem "factory_bot_rails"
  gem "pundit-matchers"
  gem "rails-controller-testing"
  gem "rspec-rails", "~> 8.0.0"
  gem "shoulda-matchers", "~> 7.0"
end

# ----------------------------------------
# == DEVELOPMENT-ONLY GROUP
# ----------------------------------------
group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"
end

# ----------------------------------------
# == TEST-ONLY GROUP
# ----------------------------------------
group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"
end
