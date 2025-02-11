# frozen_string_literal: true

require "yaml/store"

module Ruber
  class FileCache
    def initialize
      raise "FileCache requires a file path" unless Ruber.configuration.file_cache_path

      @store = YAML::Store.new(Ruber.configuration.file_cache_path)
    end

    def read(key) = @store.transaction { @store[key] }
    def write(key, value) = @store.transaction { @store[key] = value }
    def clear = File.delete(Ruber.configuration.file_cache_path) if File.exist?(Ruber.configuration.file_cache_path)
    def delete(key) = @store.transaction { @store.delete(key) }
  end
end
