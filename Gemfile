source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.2'

# load .env in project directory into environment
#gem 'dotenv-rails', groups: [:development, :test]
#gem 'dotenv-rails', :require => 'dotenv/rails-now'

#load configuration privates into environment
# don't forget to run bundle exec figaro install
# this creates a config/application.yml and
# adds it to .gitignore
gem 'figaro'

# Use sqlite3 as the database for Active Record
#gem 'sqlite3', :group => [:development, :test]
#gem 'pg', :group => :production
#gem 'sqlite3'
gem 'pg'

# Use Puma as the app server
gem 'puma', '~> 3.7'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'

# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'

gem 'jquery-turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# already in rails 5.1 ... but it seems we need to gem it anyways
#gem 'webpack-rails' ## nope not this one
gem 'webpacker', github: 'rails/webpacker'

gem 'foreman'

group :production, :staging do
  gem 'rails_12factor'
  gem 'rails_stdout_logging'
  gem 'rails_serve_static_assets'
end

#gem 'cocoon' # for jquery enabled nested forms

## editor, with plugins for images,videos, drag and drop
#gem 'wysiwyg-rails'

#gem 'font-awesome-rails'

gem 'jquery-rails'

# packages the jQuery UI assets in the asset pipeline
gem 'jquery-ui-rails'

gem 'devise'
gem 'devise_zxcvbn'
gem 'bootstrap-sass'

gem 'recaptcha', require: 'recaptcha/rails'

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :development, :test do
  # test framework, api similar to jasmine
  gem "rspec-rails"

  # better error pages for rails
  gem 'better_errors'

  # database cleanup strategies
  gem "database_cleaner"

  gem 'capybara', '~> 2.13' # test web applications, using Selenium to remote control firefox

  # test ActionMailer and Mail messages
  gem 'capybara-email', :group => :test

  # test with headless web engine
  # needs Qt
  gem 'capybara-webkit', :group => :test

  # generate fake data: names, addresses, phone numbers, etc
  # https://github.com/stympy/faker
  gem 'faker'

  # new, improved?
  # https://github.com/ffaker/ffaker
  #gem 'ffaker'

  # intercepts email, instead of sending email, pop it up
  gem 'letter_opener'

  #gem 'rails-controller-testing', :group => :test

  # fixtures
  gem "factory_girl_rails", :group => :test

  # replacement for irb
  gem 'pry'
  #gem 'pry-nav' # navigation short cuts
  gem 'pry-byebug'

  # rails console opens pry
  gem 'pry-rails', '~> 0.3.2', :group => :development

  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  #gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]

  # Behaviour Driven Development for tests
  # allows specifying tests differently
  #gem 'simple_bdd', :group => :test
  
  # collection of testing matchers
  gem 'shoulda-matchers', :group => :test

  # deployment
  # deploy using ssh
  # bundle exec cap install - generates Capfile
  gem 'capistrano'
  gem 'capistrano-rails'
  gem 'capistrano-passenger' # restart app
  gem 'capistrano-figaro-yml' # deploy secrets
  
  gem "selenium-webdriver" # ruby bindings for Selenium WebDriver

  # test rake tasks in RSpec
  #gem 'fantaskspec'
end

# for sending emails in the background
#gem "delayed_job_active_record"
# do rails generate delayed_job:active_record after bundle install and rake db:migrate for the scheduled task table

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
