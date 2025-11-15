require 'active_record'
require 'uses_index'

# Set up PostgreSQL connection
ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  database: ENV['POSTGRES_DB'] || 'uses_index_test',
  username: ENV['POSTGRES_USER'] || 'postgres',
  password: ENV['POSTGRES_PASSWORD'] || '',
  host: ENV['POSTGRES_HOST'] || 'localhost',
  port: ENV['POSTGRES_PORT'] || 5432
)

require_relative 'support/shared_examples'

RSpec.describe 'use_index matcher with PostgreSQL' do
  include_examples 'use_index matcher'
end