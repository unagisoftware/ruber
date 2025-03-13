# frozen_string_literal: true

require "yaml/store"

module Ruberto
  class FileCache
    def initialize(file_cache_path)
      @file_cache_path = file_cache_path
      @store = YAML::Store.new(file_cache_path)
    end

    def read(key) = @store.transaction { @store[key] }
    def write(key, value) = @store.transaction { @store[key] = value }

    def clear
      File.delete(@file_cache_path) if File.exist?(@file_cache_path)
    end

    def delete(key) = @store.transaction { @store.delete(key) }
  end
end
