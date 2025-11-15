Gem::Specification.new do |s|
  s.name        = 'uses_index'
  s.version     = '0.0.1'
  s.summary     = 'RSpec matcher to check if a query uses a particular index'
  s.description = 'Provides an RSpec matcher that verifies whether an ActiveRecord query is using a specific database index by examining the query execution plan. Supports SQLite and PostgreSQL.'
  s.authors     = ['Pedro Sena']
  s.email       = 'sena.pedro@gmail.com'
  s.files       = Dir['lib/**/*.rb']
  s.require_paths = ['lib']
  s.license = 'MIT'
  s.required_ruby_version = '>= 2.7'
  s.metadata = {
    'homepage_uri' => 'https://github.com/PedroSena/uses_index',
    'source_code_uri' => 'https://github.com/PedroSena/uses_index'
  }

  s.add_dependency 'activerecord', '>= 6.0'
  s.add_development_dependency 'pg', '>= 1.0'
  s.add_development_dependency 'rspec', '~> 3.0'
  s.add_development_dependency 'sqlite3', '>= 2.1'
end
