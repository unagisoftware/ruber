# frozen_string_literal: true

module Ruber
  class Configuration
    attr_accessor :customer_id, :client_id, :client_secret
    attr_writer :cache_key

    def cache_key
      @cache_key || "#{customer_id}_#{client_id}_access_token"
    end
  end

  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    def configuration=(config)
      if config.is_a?(Hash)
        config.each do |key, value|
          configuration.send "#{key}=", value
        end
      else
        @configuration = config
      end

      configuration
    end

    def configure
      yield configuration
    end
  end
end
