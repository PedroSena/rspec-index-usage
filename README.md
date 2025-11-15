# UsesIndex

An RSpec matcher that checks whether an ActiveRecord query is using a particular database index.

## Requirements

- Ruby >= 2.7
- ActiveRecord >= 6.0 (supports SQLite and PostgreSQL)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'uses_index'
```

And then execute:

    $ bundle install

This will install the gem along with its runtime dependency on ActiveRecord >= 6.0.

Or install it yourself as:

    $ gem install uses_index

## Usage

Add to your Gemfile:

```ruby
gem 'uses_index'
```

Then in your specs:

```ruby
require 'uses_index'

# In your specs
expect(User.where(email: 'test@example.com')).to use_index('index_users_on_email')
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/PedroSena/uses_index.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
