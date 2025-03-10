# frozen_string_literal: true

require_relative "ruber/version"
require "forwardable"
require "ruber/configuration"
require "ruber/authenticator"
require "ruber/request"
require "ruber/resources/delivery_resource"
require "ruber/error"

# a Ruby wrapper for Uber API
module Ruber
  autoload :Client, "ruber/client"
  autoload :Error, "ruber/error"
  autoload :Authenticator, "ruber/authenticator"
  autoload :Object, "ruber/object"

  autoload :DeliveryResource, "ruber/resources/delivery_resource"

  autoload :Collection, "ruber/collection"
  autoload :Delivery, "ruber/objects/delivery"

  DEFAULT_API_BASE = "https://api.uber.com/v1"

  Faraday.default_adapter = :net_http_persistent

  class << self
    extend Forwardable

    def_delegators(
      :configuration, :customer_id, :client_id, :client_secret,
      :customer_id=, :client_id=, :client_secret=, :cache, :cache=
    )
  end
end
