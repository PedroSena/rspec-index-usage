require 'rspec/matchers'
require 'uses_index/index_checkers/base'

RSpec::Matchers.define :use_index do |expected_index|
  match do |query|
    # query is an ActiveRecord::Relation
    connection = query.connection
    checker_class = IndexChecker.for_adapter(connection)
    checker = checker_class.new
    checker.check(query, expected_index, connection)
  end

  failure_message do |query|
    "expected query to use index '#{expected_index}', but it didn't"
  end

  failure_message_when_negated do |query|
    "expected query not to use index '#{expected_index}', but it did"
  end
end