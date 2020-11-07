# encoding: UTF-8
version = File.read(File.expand_path("../GEM_VERSION",__FILE__)).strip

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_pag_seguro'
  s.version     = version
  s.summary     = 'Spree extension for integration with PagSeguro payment'
  s.description = 'Spree extension for integration with PagSeguro payment. Based on spree_pp_website_standart gem'
  s.required_ruby_version = '>= 1.9.3'

  s.author            = 'Gregg Pollack, Sean Schofield, Tomasz Stachewicz, Buddhi DeSilva, Lucas Mousinho'
  s.email             = 'tomekrs@o2.pl'
  s.homepage          = 'http://github.com/heavenstudio/spree-pag_seguro'

  s.files        = Dir['CHANGELOG', 'README.md', 'LICENSE', 'lib/**/*', 'app/**/*', 'config/**/*', 'db/**/*', 'spec/**/*']
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree_core', '~> 4.1.10'
  s.add_dependency 'pag_seguro', '>= 0.5.6'
  s.add_dependency 'brcpfcnpj',  '~> 3.3.0'

  s.add_development_dependency 'capybara'
  s.add_development_dependency 'factory_girl'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'sqlite3'
end
