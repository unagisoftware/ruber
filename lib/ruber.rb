# frozen_string_literal: true

require_relative "ruber/version"
require "forwardable"
require "ruber/configuration"
require "ruber/authenticator"

# a Ruby wrapper for Uber API
module Ruber
  autoload :Client, "ruber/client"
  autoload :Error, "ruber/error"
  autoload :Authenticator, "ruber/authenticator"
  autoload :Object, "ruber/object"

  DEFAULT_API_BASE = "https://api.uber.com/v1"

  class << self
    extend Forwardable

    def_delegators(
      :configuration, :customer_id, :client_id, :client_secret,
      :customer_id=, :client_id=, :client_secret=, :cache, :cache=
    )
  end
end
