require 'active_record'
require 'uses_index'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')

require_relative 'support/shared_examples'

RSpec.describe 'use_index matcher with SQLite' do
  include_examples 'use_index matcher'
end