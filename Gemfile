source "http://rubygems.org"

gemspec

gem "rake"

group :development, :test do
  gem 'json', :platforms => :ruby_18
  gem 'rspec', '>= 2.11'
  gem 'webmock'
  gem 'timecop'
  gem 'rubocop', '~> 0.15.0'
end

platforms :rbx do
  gem 'rubysl', '~> 2.0'
  gem 'rubysl-json'
  gem 'parser', '2.1.0.pre1'
  gem 'racc'
end
