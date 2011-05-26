source 'http://rubygems.org'

gem 'rails', '3.0.7'
gem 'sqlite3-ruby', '1.3.2', :require => 'sqlite3'
gem 'gravatar_image_tag', '1.0.0.pre2'
gem 'will_paginate', '3.0.pre2'
gem 'faker', '0.3.1' #not used in production (obviously), but needs to be here so
#that loading the sample_data.rake won't fail when migrating heroku
gem 'rake', '0.8.7'

group :development do
  gem 'rspec-rails', '2.5.0'
  gem 'annotate-models', '1.0.4'
end

group :test do
  gem 'rspec', '2.5.0'
  gem 'webrat', '0.7.1'
  gem 'spork', '0.9.0.rc5'
  gem 'factory_girl_rails', '1.0'
end
