# frozen_string_literal: true

require_relative "configuration/memory_cache"
require_relative "configuration/file_cache"

module Ruberto
  class Configuration
    attr_accessor :customer_id, :client_id, :client_secret

    def cache
      @cache ||= MemoryCache.new
    end

    def cache=(store)
      unless %i[read write clear delete].all? { |method| store.respond_to?(method) }
        raise ArgumentError, "cache_store must respond to read, write, clear, and delete"
      end

      @cache = store
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
