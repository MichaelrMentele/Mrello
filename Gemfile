source 'https://rubygems.org'
ruby '2.3.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.0', '>= 5.0.0.1'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'
# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'
# Use JWT for signing tokens
gem 'jwt'
# Service objects standard API
gem 'simple_command'

group :test do 
  gem 'rspec-rails', '~> 3'
  gem 'shoulda-matchers'
  gem 'rails-controller-testing'
end

group :development, :test do
  gem 'pry'
  gem 'pry-nav'
  gem 'faker'
  gem 'fabrication'
end

group :development do
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'
end

group :production do 
  gem 'pg'
  gem 'puma'
end