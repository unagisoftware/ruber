# frozen_string_literal: true

module Ruber
  class Configuration
    attr_accessor :customer_id, :client_id, :client_secret
  end

  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    def configuration=(config_hash)
      config_hash.each do |key, value|
        configuration.send "#{key}=", value
      end

      configuration
    end

    def configure
      yield configuration
    end
  end
end
