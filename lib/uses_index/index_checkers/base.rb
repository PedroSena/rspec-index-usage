class IndexChecker
  def self.for_adapter(connection)
    adapter_name = connection.adapter_name
    case adapter_name
    when 'SQLite'
      require_relative 'sqlite' unless defined?(SqliteIndexChecker)
      SqliteIndexChecker
    when 'PostgreSQL'
      require_relative 'postgresql' unless defined?(PostgresqlIndexChecker)
      PostgresqlIndexChecker
    else
      raise "Unsupported database adapter: #{adapter_name}. Currently supports SQLite and PostgreSQL."
    end
  end

  def check(query, expected_index, connection = ActiveRecord::Base.connection)
    raise NotImplementedError, 'Subclasses must implement check'
  end

  def check_sql(sql, expected_index, connection = ActiveRecord::Base.connection, binds: nil)
    raise NotImplementedError, 'Subclasses must implement check_sql'
  end
end