source 'http://rubygems.org'

gem 'rails', '3.1.0'

### Test support for mongodb ###
#gem "mongoid", "~> 2.1"
#gem "bson_ext", "~> 1.3"

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3-ruby', :require => 'sqlite3'

group :production do
  gem 'pg'
end
group :development, :test do
  gem 'sqlite3'
end
# Enable gravatar
gem 'gravatar_image_tag', '1.0.0.pre2'
# Enable pagination
gem 'will_paginate', '3.0.pre2'
# Use unicorn as the web server
# gem 'unicorn'
# Enable jquery
gem 'jquery-rails', '>= 1.0.12'
# Enable tiny_mce
# gem 'tiny_mce'

# Enable amistad friendship manager
gem 'amistad'

# Enable authorization manager for user (who can see what)
gem 'cancan'

# Paperclip to add attachments to files
gem "paperclip", "~> 2.3"

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
gem "autotest"

group :development, :test do
  gem 'rspec-rails'
end

group :test do
  gem 'webrat', '0.7.1'
end
