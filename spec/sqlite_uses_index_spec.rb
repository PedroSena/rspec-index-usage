require 'active_record'
require 'rspec-index-usage'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')

require_relative 'support/shared_examples/use_index'
require_relative 'support/shared_examples/have_used_index'

RSpec.describe 'use_index matcher with SQLite' do
  include_examples 'use_index matcher'
  include_examples 'have_used_index matcher'
end