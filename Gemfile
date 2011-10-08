source 'http://rubygems.org'

gem 'rails', '3.1.0'

gem 'sass-rails'
gem 'coffee-script'
gem 'uglifier'

#gem 'less-rails-bootstrap'

group :development, :test do
  gem 'sqlite3'
end

group :production do
  gem 'pg'
	gem 'therubyracer-heroku', '0.8.1.pre3'
end

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3-ruby', :require => 'sqlite3'
# Enable gravatar
gem 'gravatar_image_tag', '1.0.0.pre2'
# Enable pagination
gem 'will_paginate', '3.0.pre2'
# Use unicorn as the web server
# gem 'unicorn'
# Enable jquery
gem 'jquery-rails', '>= 1.0.12'


# Enable amistad friendship manager
gem 'amistad'

# Enable authorization manager for user (who can see what)
gem 'cancan'

# Use carrierwave to attach files and docsplit to extract them
gem "carrierwave"
gem "docsplit"

#Deploy in Heroku
gem "heroku"

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger (ruby-debug for Ruby 1.8.7+, ruby-debug19 for Ruby 1.9.2+)
# gem 'ruby-debug'
# gem 'ruby-debug19'

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri'
# gem 'sqlite3-ruby', :require => 'sqlite3'
gem 'aws-s3'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
# group :development, :test do
#   gem 'webrat'
# end

# Autotest
#gem "autotest"

gem "rspec-rails", :group => [:test, :development]

group :test do
	gem "factory_girl_rails"
	gem "capybara"
	gem "guard-rspec"
end
