Gem::Specification.new do |s|
  s.name        = 'rspec-index-usage'
  s.version     = '0.0.1'
  s.summary     = 'RSpec matcher to check database index usage in queries'
  s.description = 'Provides RSpec matchers that verify whether ActiveRecord queries or code blocks use specific database indexes by examining execution plans. Supports SQLite and PostgreSQL.'
  s.authors     = ['Pedro Sena']
  s.email       = 'sena.pedro@gmail.com'
  s.files       = Dir['lib/**/*.rb']
  s.require_paths = ['lib']
  s.license = 'MIT'
  s.required_ruby_version = '>= 2.7'
  s.metadata = {
    'homepage_uri' => 'https://github.com/PedroSena/rspec-index-usage',
    'source_code_uri' => 'https://github.com/PedroSena/rspec-index-usage'
  }

  s.add_dependency 'activerecord', '>= 6.0'
  s.add_development_dependency 'pg', '>= 1.0'
  s.add_development_dependency 'rspec', '~> 3.0'
  s.add_development_dependency 'sqlite3', '>= 2.1'
end
