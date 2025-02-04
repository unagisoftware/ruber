# frozen_string_literal: true

require File.expand_path("../test_helper", __dir__)

module Ruber
  class ConfigurationTest < Minitest::Test
    def test_configure
      Ruber.configure do |config|
        config.customer_id = "1111"
        config.client_id = "2222"
        config.client_secret = "a-secret"
      end

      assert_equal "1111", Ruber.customer_id
      assert_equal "2222", Ruber.client_id
      assert_equal "a-secret", Ruber.client_secret
    end
  end
end
