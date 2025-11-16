# RSpec Index Usage

RSpec matchers that check database index usage in ActiveRecord queries and code blocks.

## Requirements

- Ruby >= 2.7
- ActiveRecord >= 6.0 (supports SQLite and PostgreSQL)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rspec-index-usage'
```

And then execute:

    $ bundle install

This will install the gem along with its runtime dependency on ActiveRecord >= 6.0.

Or install it yourself as:

    $ gem install rspec-index-usage

## Usage

Add to your Gemfile:

```ruby
gem 'rspec-index-usage'
```

Then in your specs:

```ruby
require 'rspec-index-usage'

# In your specs
expect(User.where(email: 'test@example.com')).to use_index('index_users_on_email')
expect { User.where(email: 'test@example.com').first }.to have_used_index('index_users_on_email')
expect { User.where(email: 'test@example.com').first }.to have_used_index('index_users_on_email').on_connection(OtherDb.connection)
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/PedroSena/rspec-index-usage.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
