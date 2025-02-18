# frozen_string_literal: true

require_relative "ruber/version"
require "forwardable"
require "ruber/configuration"
require "ruber/authenticator"
require "ruber/request"
require "ruber/resources/delivery_resource"

# a Ruby wrapper for Uber API
module Ruber
  autoload :Client, "ruber/client"
  autoload :Error, "ruber/error"
  autoload :Authenticator, "ruber/authenticator"
  autoload :Object, "ruber/object"

  autoload :DeliveryResource, "ruber/resources/delivery_resource"

  autoload :Delivery, "ruber/objects/delivery"

  DEFAULT_API_BASE = "https://api.uber.com/v1"

  class << self
    extend Forwardable

    def_delegators(
      :configuration, :customer_id, :client_id, :client_secret,
      :customer_id=, :client_id=, :client_secret=, :cache, :cache=
    )
  end

  Ruber.customer_id = "6edc706a-81ea-5cf1-b4bc-64442190779d"
  Ruber.client_id = "OYLrhSvGggX0Se4Vv9t6vfnbpF6vobn8"
  Ruber.client_secret = "91XrGb1HjOMEJSIht225km3Q_xJlucaKsYySc5_o"
  Ruber.configuration.file_cache_path = "file_cache.yaml"
end
