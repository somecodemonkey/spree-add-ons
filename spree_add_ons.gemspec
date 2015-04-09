# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_add_ons'
  s.version     = '2.4.6'
  s.summary     = 'Allows products to have add ons with corresponding features and fees.'
  s.description = 'See summary.'
  s.required_ruby_version = '>= 1.9.3'

  s.author    = "Darby Perez, Anthony D'addeo"
  s.email     = 'darby@personalwine.com, anthony@personalwine.com'
  s.homepage  = 'http://www.personalwine.com'

  #s.files       = `git ls-files`.split("\n")
  #s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree_core', '~> 2.4.6'
  s.add_dependency 'slim'
  s.add_dependency 'active_model_serializers'
  # s.add_dependency 'unscoped_associations'

  s.add_development_dependency 'capybara', '~> 2.4'
  s.add_development_dependency 'coffee-rails'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'factory_girl', '~> 4.5'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'rspec-rails',  '~> 3.1'
  s.add_development_dependency 'rspec-activemodel-mocks',  '~> 1.0.1'
  s.add_development_dependency 'shoulda-matchers',  '~> 2.8.0'
  s.add_development_dependency 'shoulda-callback-matchers', '~> 1.1.1'
  s.add_development_dependency 'sass-rails', '~> 4.0.2'
  s.add_development_dependency 'selenium-webdriver'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'sqlite3'
end
