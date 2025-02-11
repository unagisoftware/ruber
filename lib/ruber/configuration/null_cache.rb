# frozen_string_literal: true

module Ruber
  class Configuration
    class NullCache
      def read(key) = memory_store[key]
      def write(key, value, _options = {}) = memory_store[key] = value
      def clear = memory_store.clear
      def delete(key) = memory_store.delete(key)
      def memory_store = @memory_store ||= {}
    end
  end
end
