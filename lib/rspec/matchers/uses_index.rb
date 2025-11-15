require 'rspec/matchers'
require 'uses_index/index_checkers/base'

RSpec::Matchers.define :use_index do |expected_index|
  match do |query|
    # Assuming query is an ActiveRecord::Relation
    checker_class = IndexChecker.for_adapter(ActiveRecord::Base.connection.adapter_name)
    checker = checker_class.new
    checker.check(query, expected_index)
  end

  failure_message do |query|
    "expected query to use index '#{expected_index}', but it didn't"
  end

  failure_message_when_negated do |query|
    "expected query not to use index '#{expected_index}', but it did"
  end
end