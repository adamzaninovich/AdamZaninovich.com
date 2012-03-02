source 'https://rubygems.org'

gem 'rails', '3.2.2'

group :production do
  gem 'pg'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'twitter-bootstrap-rails'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.0.0'

group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'launchy'
  gem 'spork'
  gem 'autotest',            require: false
  gem 'autotest-rails-pure', require: false
  gem 'autotest-fsevent',    require: false
  gem 'autotest-growl',      require: false
end
