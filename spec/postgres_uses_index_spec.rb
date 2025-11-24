require 'active_record'
require 'active_record/tasks/database_tasks'
require 'rspec-index-usage'

# Database configuration
db_config = {
  adapter: 'postgresql',
  database: ENV['POSTGRES_DB'] || 'uses_index_test',
  username: ENV['POSTGRES_USER'] || 'postgres',
  password: ENV['POSTGRES_PASSWORD'] || 'postgres',
  host: ENV['POSTGRES_HOST'] || 'localhost',
  port: ENV['POSTGRES_PORT'] || 5432
}

# Create the test database if it doesn't exist
temp_config = db_config.merge(database: 'postgres')
ActiveRecord::Base.establish_connection(temp_config)
begin
  ActiveRecord::Tasks::DatabaseTasks.create(db_config)
rescue ActiveRecord::DatabaseAlreadyExists
  # Database already exists, ignore
end

# Set up PostgreSQL connection to the test database
ActiveRecord::Base.establish_connection(db_config)

require_relative 'support/shared_examples/use_index'
require_relative 'support/shared_examples/have_used_index'

RSpec.describe 'use_index matcher with PostgreSQL' do
  include_examples 'use_index matcher'
  include_examples 'have_used_index matcher'
end
