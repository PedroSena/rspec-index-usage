require_relative 'base'

class SqliteIndexChecker < IndexChecker
  def check(query, expected_index, connection = ActiveRecord::Base.connection)
    sql = query.to_sql
    check_sql(sql, expected_index, connection)
  end

  def check_sql(sql, expected_index, connection = ActiveRecord::Base.connection, binds: nil)
    sql = substitute_binds(sql, binds, connection) if binds
    explain_sql = "EXPLAIN QUERY PLAN #{sql}"
    result = connection.execute(explain_sql)
    plan = result.map { |row| row.values.join(' ') }.join(' ')
    plan.downcase.include?(expected_index.downcase)
  end

  private

  def substitute_binds(sql, binds, connection)
    parts = sql.split('?')
    if parts.size - 1 == binds.size
      sql = parts.zip(binds.map { |bind| connection.quote(bind.value) }).flatten.compact.join
    end
    sql
  end
end
