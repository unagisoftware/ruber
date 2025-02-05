# frozen_string_literal: true

require File.expand_path("../test_helper", __dir__)

module Ruber
  class ConfigurationTest < Minitest::Test
    def setup
      @config_values = { customer_id: "1111", client_id: "2222", client_secret: "a-secret" }
    end

    def test_configure
      Ruber.configure do |config|
        config.customer_id = @config_values[:customer_id]
        config.client_id = @config_values[:client_id]
        config.client_secret = @config_values[:client_secret]
      end

      assert_configuration_values
    end

    def test_direct_configuration
      Ruber.customer_id = @config_values[:customer_id]
      Ruber.client_id = @config_values[:client_id]
      Ruber.client_secret = @config_values[:client_secret]

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

    private

    def assert_configuration_values
      assert_equal @config_values[:customer_id], Ruber.customer_id
      assert_equal @config_values[:client_id], Ruber.client_id
      assert_equal @config_values[:client_secret], Ruber.client_secret
    end
  end
end
