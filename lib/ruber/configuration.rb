# frozen_string_literal: true

require_relative "configuration/null_cache"

module Ruber
  class Configuration
    attr_accessor :customer_id, :client_id, :client_secret
    attr_writer :cache_key

    def cache
      @cache ||= NullCache.new
    end

    def cache=(store)
      unless %i[read write clear delete].all? { |method| store.respond_to?(method) }
        raise ArgumentError, "cache_store must respond to read, write, clear, and delete"
      end

      @cache = store
    end

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
