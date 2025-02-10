# frozen_string_literal: true

require File.expand_path("../test_helper", __dir__)

module Ruber
  class ConfigurationTest < Minitest::Test
    def setup
      @config_values = {
        customer_id: "1111",
        client_id: "2222",
        client_secret: "a-secret",
        cache_key: "custom_cache_key"
      }

      Ruber.configuration = nil
    end

    def test_configure
      Ruber.configure do |config|
        config.customer_id    = @config_values[:customer_id]
        config.client_id      = @config_values[:client_id]
        config.client_secret  = @config_values[:client_secret]
        config.cache_key      = @config_values[:cache_key]
      end

      assert_configuration_values
    end

    def test_direct_configuration
      Ruber.customer_id       = @config_values[:customer_id]
      Ruber.client_id         = @config_values[:client_id]
      Ruber.client_secret     = @config_values[:client_secret]
      Ruber.cache_key         = @config_values[:cache_key]

      assert_configuration_values
    end

    def test_valid_configuration_set
      Ruber.configuration = @config_values

      assert_configuration_values
    end

    def test_invalid_configuration_set
      assert_raises(NoMethodError) do
        Ruber.configuration = { user_password: "123456" }
      end
    end

    def test_cache_key_is_set_by_default
      Ruber.configure do |config|
        config.customer_id = "1111"
        config.client_id = "2222"
      end

      assert_equal "1111_2222_access_token", Ruber.cache_key
    end

    def test_cache_key_can_be_set_explicitly
      Ruber.configure do |config|
        config.customer_id = "1111"
        config.client_id = "2222"
        config.cache_key = @config_values[:cache_key]
      end

      assert_equal @config_values[:cache_key], Ruber.cache_key
    end

    private

    def assert_configuration_values
      assert_equal @config_values[:customer_id], Ruber.customer_id
      assert_equal @config_values[:client_id], Ruber.client_id
      assert_equal @config_values[:client_secret], Ruber.client_secret
      assert_equal @config_values[:cache_key], Ruber.cache_key
    end
  end
end
