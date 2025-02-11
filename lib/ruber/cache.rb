# frozen_string_literal: true

module Ruber
  class NullCache
    def read(key) = memory_store[key]
    def write(key, value, _options = {}) = memory_store[key] = value
    def clear = memory_store.clear
    def delete(key) = memory_store.delete(key)
    def memory_store = @memory_store ||= {}
  end

  class << self
    def cache=(store)
      unless %i[read write clear delete].all? { |method| store.respond_to?(method) }
        raise ArgumentError, "cache_store must respond to read, write, clear, and delete"
      end

      @cache = store
    end

    def cache
      @cache ||= NullCache.new
    end
  end
end
