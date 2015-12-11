# Julia Builder
[![Gem Version](https://badge.fury.io/rb/julia_builder.svg)](https://badge.fury.io/rb/julia_builder)
[![Build Status](https://travis-ci.org/stevenbarragan/julia_builder.svg?branch=master)](https://travis-ci.org/stevenbarragan/julia_builder)
[![Test Coverage](https://codeclimate.com/github/stevenbarragan/julia_builder/badges/coverage.svg)](https://codeclimate.com/github/stevenbarragan/julia_builder/coverage)

Julia helps you out to create flexible builders to easily export your queries to csv (for now).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'julia_builder'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install julia_builder

For non rails projects

```ruby
require 'julia'
```

## Usage

1. Create your own builder class, inherit from `Julia::Builder` and configure your csv columns.

    ```ruby
    class UserCsv < Julia::Builder
      # specify column's header and value
      column 'Birthday', :dob
      # header equals 'Birthday' and the value will be on `user.dbo`

      # when header and value are the same, no need to duplicate it.
      column :name
      # header equals 'name', value will be `user.name`

      # when you need to do some extra work on the value you can pass a proc.
      column 'Full name', -> { "#{ name.capitalize } #{ last_name.capitalize }" }

      # or you can pass a block
      column 'Type' do |user|
        user.class.name
      end
    end
    ```

2. Now you can use your builder to generate your csv out of a query like:

    ```ruby
    users = User.all
    UserCsv.build(users)

    # or

    UserCsv.build(users, <csv options>)
    ```

    Csv options could be anything [CSV::new](http://ruby-doc.org/stdlib-2.0.0/libdoc/csv/rdoc/CSV.html#method-c-new) understands, but they are optional.

3. Enjoy

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/stevenbarragan/julia_builder/issues. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org/) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

