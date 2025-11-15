require_relative '../models'

RSpec.shared_examples 'use_index matcher' do
  before(:all) do
    CreateUsers.new.change
    User.create!(email: 'test@example.com', name: 'John')
  end

  after(:all) do
    ActiveRecord::Migration.drop_table :users if ActiveRecord::Base.connection.table_exists?(:users)
  end

  it 'matches when the query uses the specified index' do
    query = User.where(email: 'test@example.com')
    expect(query).to use_index('index_users_on_email')
  end

  it 'does not match when the query does not use the specified index' do
    query = User.where(email: 'test@example.com')
    expect(query).not_to use_index('non_existent_index')
  end

  it 'does not match when querying a non-indexed column' do
    query = User.where(name: 'John')
    expect(query).not_to use_index('index_users_on_email')
  end

  it 'raises an error for unsupported database adapters' do
    allow(ActiveRecord::Base.connection).to receive(:adapter_name).and_return('MySQL')
    query = User.where(email: 'test@example.com')
    expect { expect(query).to use_index('index_users_on_email') }.to \
      raise_error('Unsupported database adapter: MySQL. Currently supports SQLite and PostgreSQL.')
  end
end