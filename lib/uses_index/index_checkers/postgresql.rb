require_relative 'base'

class PostgresqlIndexChecker < IndexChecker
  def check(query, expected_index)
    sql = query.to_sql
    check_sql(sql, expected_index)
  end

  def check_sql(sql, expected_index)
    explain_sql = "EXPLAIN #{sql}"
    result = ActiveRecord::Base.connection.execute(explain_sql)
    plan = result.map { |row| row[0] }.join("\n")
    plan.include?(expected_index)
  end
end

