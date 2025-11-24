require 'rspec/matchers'
require 'uses_index/index_checkers/base'
require 'active_support/notifications'

RSpec::Matchers.define :have_used_index do |expected_index|
  supports_block_expectations

  attr_accessor :connection

  chain :on_connection do |conn|
    @connection = conn
  end

  match do |block|
    queries = []
    subscriber = ActiveSupport::Notifications.subscribe('sql.active_record') do |*args|
      event = ActiveSupport::Notifications::Event.new(*args)
      sql = event.payload[:sql]
      next unless sql

      if sql.start_with?('SELECT') && !sql.match?(/\A(EXPLAIN|BEGIN|COMMIT|ROLLBACK)/i)
        queries << { sql: sql, binds: event.payload[:binds] }
      end
    end

    block.call

    ActiveSupport::Notifications.unsubscribe(subscriber)

    connection = @connection || ActiveRecord::Base.connection
    checker_class = IndexChecker.for_adapter(connection)
    checker = checker_class.new

    queries.any? { |query| checker.check_sql(query[:sql], expected_index, connection, binds: query[:binds]) }
  end

  failure_message do |_block|
    "expected the block to execute a query using index '#{expected_index}', but none did"
  end

  failure_message_when_negated do |_block|
    "expected the block not to execute a query using index '#{expected_index}', but one did"
  end
end
