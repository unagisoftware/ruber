# frozen_string_literal: true

require File.expand_path("../../test_helper", __dir__)
require "yaml/store"
require "fileutils"

module Ruber
  class FileCacheTest < Minitest::Test
    def setup
      File.delete(Ruber.configuration.file_cache_path) if File.exist?(Ruber.configuration.file_cache_path)

      @cache = FileCache.new
    end

    def teardown
      File.delete(Ruber.configuration.file_cache_path) if File.exist?(Ruber.configuration.file_cache_path)
    end

    def test_initialize_raises_error_if_no_file_path
      Ruber.configuration.stub :file_cache_path, nil do
        assert_raises(RuntimeError, "FileCache requires a file path") do
          FileCache.new
        end
      end
    end

    def test_write_and_read
      @cache.write("foo", "bar")
      assert_equal "bar", @cache.read("foo")
    end

    def test_delete
      @cache.write("key", "value")
      @cache.delete("key")
      assert_nil @cache.read("key")
    end

    def test_clear
      @cache.write("key1", "value1")
      @cache.write("key2", "value2")

      @cache.clear
      assert_nil @cache.read("key1")
      assert_nil @cache.read("key2")
    end
  end
end
