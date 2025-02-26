# Ruber

The easiest way to integrate to Uber API.

> The current version includes the integration with the Uber Direct API.

## Installation

Add this line to your application's Gemfile:

```
gem 'ruber', github: "unagisoftware/ruber.rb"
```

And then execute:

```
$ bundle
```

## Usage

To access the API, you'll need to create an account on Uber (see the [Uber developers website](https://developer.uber.com) for more information). Once you have your account, go to the developer options to find your `customer_id`, `client_id`, and `client_secret`.

You need to pass those values to the gem. We recommend doing this using an initializer. Run the following command to create a sample initializer:

```bash
rails generate ruber:init
```

This will create an initializer where you can set the variables:

```ruby
Ruber.configure do |config|
  config.customer_id = 'uber-customer-id'
  config.client_id = 'uber-client-id'
  config.client_secret = 'uber-client-secret'
end
```

## Cache
Ruber uses a caching solution to improve efficiency (e.g., for caching tokens). By default, it uses a simple file cache, but you can change the cache method by setting the `Ruber.cache` attribute:

```ruby
Ruber.cache = Redis.new
# or
Ruber.cache = Rails.cache
# or any object that responds to read/write/delete/clear
Ruber.cache = YourCustomCache.new
```

### File cache

File cache is the default cache option. In case you want to go for this option, you'll need to set the `file_cache_path` attribute to determine where to save the file. Make sure that this path is in your `.gitignore` to avoid pushing your token to the repo.

## Resources

Responses are created as objects (e.g. Ruber::Delivery) using [Data Define](https://docs.ruby-lang.org/en/3.2/Data.html), allowing you to access data in a Ruby-ish way.

### DeliveryResource

```ruby
Ruber::DeliveryResource.all
#=> Ruber::Collection of Ruber::Delivery

Ruber::DeliveryResource.find("del_id")
#=> Ruber::Delivery

Ruber::DeliveryResource.create({...}}
#=> Ruber::Delivery

Ruber::DeliveryResource.cancel("del_id")
#=> Ruber::Delivery

Ruber::DeliveryResource.update("del_id", {...})
#=> Ruber::Delivery

Ruber::DeliveryResource.update("del_id", {...})
#=> Ruber::Delivery::ProofOfDelivery
```

## Errors
If the Uber API returns an error, a `Ruber::Error` exception is raised. Ruber::Error provides the following accessors: `message`, `metadata`, `status`:

```ruby
error.message
# => "An active delivery like this already exists."
error.metadata
# => .{ "delivery_id": "del_4y-aAymET6KH9TGTJ-ydxx" }
error.status
# => 409
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/unagisoftware/ruber. This project is intended to be a safe, welcoming space for collaboration.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
