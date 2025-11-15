class IndexChecker
  def self.for_adapter(adapter_name)
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

  def check(query, expected_index)
    raise NotImplementedError, 'Subclasses must implement check'
  end
end