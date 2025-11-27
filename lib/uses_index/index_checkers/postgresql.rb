require_relative 'base'

class PostgresqlIndexChecker < IndexChecker
  def check(query, expected_index, connection = ActiveRecord::Base.connection)
    sql = query.to_sql
    check_sql(sql, expected_index, connection)
  end

  def check_sql(sql, expected_index, connection = ActiveRecord::Base.connection, binds: nil)
    sql = substitute_binds(sql, binds, connection) if binds
    explain_sql = "EXPLAIN #{sql}"
    result = connection.execute(explain_sql)
    plan = result.map { |row| row['QUERY PLAN'] }.join("\n")
    plan.downcase.include?(expected_index.downcase)
  end

  private

  def substitute_binds(sql, binds, connection)
    binds.each_with_index do |bind, index|
      placeholder = "$#{index + 1}"
      quoted_value = connection.quote(bind.value)
      sql = sql.gsub(placeholder, quoted_value)
    end
    sql
  end
end
