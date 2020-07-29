source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'rails',      '6.0.3'
gem 'chartkick'
gem 'mini_magick'
gem 'aws-sdk-s3'
gem 'kaminari'
gem 'kaminari-bootstrap'
gem 'rails-i18n'
gem 'faker'
gem 'bcrypt', '3.1.12'
gem 'bootstrap', '~> 4.3.1'
gem "jquery-rails", "~> 4.3"
gem 'puma',       '4.3.4'
gem 'sassc-rails'
gem 'webpacker',  '4.0.7'
gem 'turbolinks', '5.2.0'
gem 'jbuilder',   '2.9.1'
gem 'bootsnap',   '1.4.5', require: false
gem 'jquery-turbolinks'

group :development, :test do
  gem 'capybara', '3.28.0'
  gem 'rails-controller-testing'
  gem "factory_bot_rails"
  gem 'sqlite3', '1.4.1'
  gem 'byebug',  '11.0.1', platforms: [:mri, :mingw, :x64_mingw]
  gem 'database_cleaner'
  gem 'rspec-rails'
end

group :development do
  gem 'web-console',           '4.0.1'
  gem 'listen',                '3.1.5'
  gem 'spring',                '2.1.0'
  gem 'spring-watcher-listen', '2.0.1'
end

group :test do
  gem 'capybara',                 '3.28.0'
  gem 'selenium-webdriver',       '3.142.4'
  gem 'webdrivers',               '4.1.2'
  gem 'minitest',                 '5.11.3'
  gem 'minitest-reporters',       '1.3.8'
  gem 'guard',                    '2.16.2'
  gem 'guard-minitest',           '2.4.6'
  gem 'rspec-rails'
end


# Windows ではタイムゾーン情報用の tzinfo-data gem を含める必要があります
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]