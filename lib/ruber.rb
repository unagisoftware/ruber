# frozen_string_literal: true

require_relative "ruber/version"
require "forwardable"
require "ruber/configuration"

module Ruber
  autoload :Client, "ruber/client"
  autoload :Error, "ruber/error"

  DEFAULT_API_BASE = "https://api.uber.com/v1"

  class << self
    extend Forwardable

    def_delegators :configuration, :customer_id, :client_id, :client_secret
  end
end
