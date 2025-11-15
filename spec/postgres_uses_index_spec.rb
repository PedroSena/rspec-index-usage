require 'active_record'
require 'rspec-index-usage'

# Set up PostgreSQL connection
ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  database: ENV['POSTGRES_DB'] || 'uses_index_test',
  username: ENV['POSTGRES_USER'] || 'postgres',
  password: ENV['POSTGRES_PASSWORD'] || '',
  host: ENV['POSTGRES_HOST'] || 'localhost',
  port: ENV['POSTGRES_PORT'] || 5432
)

require_relative 'support/shared_examples/use_index'
require_relative 'support/shared_examples/have_used_index'

RSpec.describe 'use_index matcher with PostgreSQL' do
  include_examples 'use_index matcher'
  include_examples 'have_used_index matcher'
end