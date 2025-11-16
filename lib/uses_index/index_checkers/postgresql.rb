require_relative 'base'

class PostgresqlIndexChecker < IndexChecker
  def check(query, expected_index, connection = ActiveRecord::Base.connection)
    sql = query.to_sql
    check_sql(sql, expected_index, connection)
  end

  def check_sql(sql, expected_index, connection = ActiveRecord::Base.connection)
    explain_sql = "EXPLAIN #{sql}"
    result = connection.execute(explain_sql)
    plan = result.map { |row| row[0] }.join("\n")
    plan.include?(expected_index)
  end
end

