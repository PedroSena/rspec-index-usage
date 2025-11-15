require_relative '../models'

RSpec.shared_examples 'have_used_index matcher' do
  before(:all) do
    CreateUsers.new.change unless ActiveRecord::Base.connection.table_exists?(:users)
    User.create!(email: 'test@example.com', name: 'John')
  end

  after(:all) do
    ActiveRecord::Migration.drop_table :users if ActiveRecord::Base.connection.table_exists?(:users)
  end

  it 'matches when the block executes a query using the specified index' do
    expect {
      User.where(email: 'test@example.com').first
    }.to have_used_index('index_users_on_email')
  end

  it 'does not match when the block does not execute a query using the specified index' do
    expect {
      User.where(email: 'test@example.com').first
    }.not_to have_used_index('non_existent_index')
  end

  it 'does not match when the block queries a non-indexed column' do
    expect {
      User.where(name: 'John').first
    }.not_to have_used_index('index_users_on_email')
  end

  it 'matches when multiple queries are executed and at least one uses the index' do
    expect {
      User.where(name: 'John').first
      User.where(email: 'test@example.com').first
    }.to have_used_index('index_users_on_email')
  end

  it 'raises an error for unsupported database adapters' do
    allow(ActiveRecord::Base.connection).to receive(:adapter_name).and_return('MySQL')
    expect {
      expect { User.where(email: 'test@example.com').first }.to have_used_index('index_users_on_email')
    }.to raise_error('Unsupported database adapter: MySQL. Currently supports SQLite and PostgreSQL.')
  end

  it 'does not match when the block only executes mutations without SELECT queries' do
    expect {
      User.create!(email: 'new@example.com', name: 'Jane')
    }.not_to have_used_index('index_users_on_email')
  end

  it 'does not match when the block executes mutations and a SELECT that does not use the index' do
    expect {
      User.create!(email: 'another@example.com', name: 'Bob')
      User.where(name: 'Bob').first
    }.not_to have_used_index('index_users_on_email')
  end

  it 'matches when the block executes mutations and a SELECT that uses the index' do
    expect {
      User.create!(email: 'third@example.com', name: 'Alice')
      User.where(email: 'third@example.com').first
    }.to have_used_index('index_users_on_email')
  end
end