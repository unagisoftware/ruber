# Ruberto

This gem helps you seamlessly connect your Ruby app with Uber’s services. Hop in, let’s ride!

### Why Ruberto?

It was originally named `Ruber`, because, well... it’s built in Ruby and integrates with Uber. See what we did there? 😏

Then we sadly realized that the name was already taken, so we renamed it to `Ruberto`. Hope you like it!

> The current version includes the integration with the Uber Direct API.


## Installation

Add this line to your application's Gemfile:

```
gem 'ruberto'
```

And then execute:

```
$ bundle
```
## Configuration
Ruberto can be customized using various configuration options. To see the full list, run the `init` generator to create an initializer with all the options. Then, uncomment the variables you want to customize.

```bash
rails generate ruberto:init
# This will create a file ruberto.rb under config/initializers
```

## Usage

To access the API, you'll need to create an account on Uber (see the [Uber developers website](https://developer.uber.com) for more information). Once you have your account, go to the developer options to find your `customer_id`, `client_id`, and `client_secret`.

You need to pass those values to the gem. You can do this from anywhere, but we recommend using an initializer like this:

```ruby
Ruberto.configure do |config|
  config.customer_id = 'uber-customer-id'
  config.client_id = 'uber-client-id'
  config.client_secret = 'uber-client-secret'
end
```

_ℹ️ If you run the `init` generator you should set the attributes in the generated initializer (`config/initializers/ruberto`)_

## Cache
Ruberto uses a caching solution to improve efficiency (e.g., for caching tokens). By default, it uses a simple memory cache,
but you can change the cache method by setting the `Ruberto.cache` attribute.

```ruby
Ruberto.cache = Redis.new
# or
Ruberto.cache = Rails.cache
# or any object that responds to read/write/delete/clear
Ruberto.cache = YourCustomCache.new
```

> Try not to use the memory cache in production, as it will be cleared on every request.


### File cache

Ruberto comes with a simple File cache option. It uses a yaml file to store the cached data.

```yml
---
# Example of file automatically generated
:access_token:
  :token: IA.VUNmGAAAAAAAEgASAAAABwAIAAwAAAAAAAAAEgAAAAAAAAGwAAAAFAAAAAAADgAQAAQAAAAIAAwAAAAOAAAAhAAAABwAAAAEAAAAEAAAAKbivxMQNu9xZfQn_LJeh75fAAAAcqjQlrRGJjknFRPDLARG0Uj0kIvmkIh7cy_HI8cPjKMP4ja0xAvKLSJ1H9eU1ALQJkExzcMwvMkPyVjpSm-c4Wk1S__oSOK_pkAX1kywZr8sBpP_gtPwBhrz3SF8L6YADAAAALkCO6lUHox2Dp907iQAAABiMGQ4NTgwMy0zOGEwLTQyYjMtODA2ZS03YTRjZjhlMTk2ZWU
  :expires_at: 2025-03-27 16:46:12.256308000 -03:00
```

In case you want to go for this option, you'll need to set the `file_cache_path` attribute to determine where to save the file.

‼️ **Make sure that this path is in your `.gitignore` to avoid pushing your token to the repo.**

## Resources

Ruberto maps resources from the Uber API to internal resources. For example, `Ruberto::DeliveryResource` lets you create, find, list, cancel, and manage deliveries in Uber. When you call these methods on a resource, it returns objects created using OpenStruct, allowing you to access data in a Ruby-like way.

```ruby
delivery = Ruberto::DeliveryResource.find("del_id1231asdfas")
#=> Ruberto::Delivery
delivery.id
#=> del_id1231asdfas
```

### DeliveryResource

```ruby
Ruberto::DeliveryResource.all
#=> Ruberto::Collection of Ruberto::Delivery

Ruberto::DeliveryResource.find("del_id")
#=> Ruberto::Delivery

Ruberto::DeliveryResource.create({...}}
#=> Ruberto::Delivery

Ruberto::DeliveryResource.cancel("del_id")
#=> Ruberto::Delivery

Ruberto::DeliveryResource.update("del_id", {...})
#=> Ruberto::Delivery

Ruberto::DeliveryResource.proof_of_delivery("del_id", {...})
#=> Ruberto::Delivery::ProofOfDelivery
```

## Authentication
To access the Uber API, you need a valid access token from Uber's OAuth service. All requests to https://api.uber.com/ use OAuth 2.0 with the client_credentials grant type.

Authentication and caching are handled automatically by the gem. The only thing you need to do is provide the required credentials (`customer_id`, `client_id`, and `client_secret`).

## Errors
If the Uber API returns an error, a `Ruberto::Error` exception is raised. Ruberto::Error provides the following accessors: `message`, `metadata`, `status`:

```ruby
begin
  Ruberto::DeliveryResource.create(...)
rescue Ruberto::Error => error
  puts error.message # "The pickup address is invalid"
  puts error.metadata # { "pickup_address": "123 Fake Street, Nowhere" }
  puts error.status # 400
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/unagisoftware/ruberto. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/unagisoftware/ruberto/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Ruberto project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/unagisoftware/ruberto/blob/master/CODE_OF_CONDUCT.md).

## About Unagi

<img width="208" alt="isologotipo naranja cuadrado" style="margin:auto" src="https://github.com/user-attachments/assets/05750673-b2ba-473a-b8c6-c400a4403a4a" />

This repo is maintained and funded by [Unagi](https://unagisoftware.com).

Do you want to hire us? [Let's get in touch!](https://unagisoftware.com/#contact)
