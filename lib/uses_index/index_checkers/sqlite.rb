require_relative 'base'

class SqliteIndexChecker < IndexChecker
  def check(query, expected_index)
    sql = query.to_sql
    explain_sql = "EXPLAIN QUERY PLAN #{sql}"
    result = ActiveRecord::Base.connection.execute(explain_sql)
    plan = result.map { |row| row.values.join(' ') }.join(' ')
    plan.include?(expected_index)
  end
end