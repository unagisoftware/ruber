# frozen_string_literal: true

require_relative "ruberto/version"
require "forwardable"
require "ruberto/configuration"
require "ruberto/authenticator"
require "ruberto/request"
require "ruberto/resources/delivery_resource"
require "ruberto/error"

# a Ruby wrapper for Uber API
module Ruberto
  autoload :Client, "ruberto/client"
  autoload :Error, "ruberto/error"
  autoload :Authenticator, "ruberto/authenticator"
  autoload :Object, "ruberto/object"

  autoload :DeliveryResource, "ruberto/resources/delivery_resource"

  autoload :Collection, "ruberto/collection"
  autoload :Delivery, "ruberto/objects/delivery"

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
