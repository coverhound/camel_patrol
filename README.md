# CamelPatrol 🐪🚓

Inspired by [olive_branch](https://github.com/vigetlabs/olive_branch),
CamelPatrol is a middleware with a singular focus: Creating a border between 🐪 and 🐍.

In Ruby, we like to have `snake_case` variables, whereas using Javascript and
JSON, the convention is generally to use `camelCase`. This gem is the answer to
"Why not both?"

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'camel_patrol'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install camel_patrol

## Usage

### Rails app
To use this in a normal rails application, you can add it to your application.rb

```rb
# config/application.rb

# Adds our middleware to the end of the stack
config.middleware.use CamelPatrol::Middleware
```

For more information from the official Rails docs, go
[here](http://guides.rubyonrails.org/rails_on_rack.html#configuring-middleware-stack)


### Rails engine
In order to add it to an engine, you'll want to add it in your engine file:

```rb
# my_engine/lib/engine.rb

# Adds our middleware to the end of the stack
config.middleware.use CamelPatrol::Middleware
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/coverhound/camel_patrol.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

