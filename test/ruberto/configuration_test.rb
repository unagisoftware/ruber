# frozen_string_literal: true

require File.expand_path("../test_helper", __dir__)

module Ruberto
  class ConfigurationTest < Minitest::Test
    def setup
      @config_values = {
        customer_id: "1111",
        client_id: "2222",
        client_secret: "a-secret"
      }

      @custom_cache = Class.new do
        def read(key) = memory_store[key]
        def write(key, value, _options = {}) = memory_store[key] = value
        def clear = memory_store.clear
        def delete(key) = memory_store.delete(key)
        def memory_store = @memory_store ||= {}
      end.new

      Ruberto.configuration = nil
    end

    def test_configure
      Ruberto.configure do |config|
        config.customer_id    = @config_values[:customer_id]
        config.client_id      = @config_values[:client_id]
        config.client_secret  = @config_values[:client_secret]
      end

      assert_configuration_values
    end

    def test_direct_configuration
      Ruberto.customer_id       = @config_values[:customer_id]
      Ruberto.client_id         = @config_values[:client_id]
      Ruberto.client_secret     = @config_values[:client_secret]

      assert_configuration_values
    end

    def test_valid_configuration_set
      Ruberto.configuration = @config_values

      assert_configuration_values
    end

    def test_invalid_configuration_set
      assert_raises(NoMethodError) do
        Ruberto.configuration = { user_password: "123456" }
      end
    end

    def test_cache_can_be_set_explicitly
      Ruberto.cache = @custom_cache

      assert_equal @custom_cache, Ruberto.cache
    end

    def test_cache_must_respond_to_read_write_clear_and_delete
      assert_raises(ArgumentError) do
        Ruberto.cache = Object.new
      end
    end

    private

    def assert_configuration_values
      assert_equal @config_values[:customer_id], Ruberto.customer_id
      assert_equal @config_values[:client_id], Ruberto.client_id
      assert_equal @config_values[:client_secret], Ruberto.client_secret
    end
  end
end
