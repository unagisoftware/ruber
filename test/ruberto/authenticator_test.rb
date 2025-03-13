# frozen_string_literal: true

require File.expand_path("../test_helper", __dir__)
require "webmock/minitest"

module Ruberto
  class AuthenticatorTest < Minitest::Test
    include WebMock::API

    def setup
      Ruberto.cache = Ruberto::FileCache.new("test/tmp/ruberto_cache.yaml")
      Ruberto.cache.clear
    end

    def test_access_token_fetches_and_caches_token
      stub_token_request(access_token: "new_token", expires_in: 3600)

      token = Authenticator.access_token
      cached_token = Ruberto.cache.read(Authenticator.cache_key)

      assert_equal "new_token", token
      assert_equal "new_token", cached_token[:token]
    end

    def test_refresh_access_token_forces_new_token
      Ruberto.cache.write(Authenticator.cache_key, { token: "old_token", expires_at: Time.now + 3600 })

      stub_token_request(access_token: "refreshed_token", expires_in: 3600)

      token = Authenticator.refresh_access_token
      cached_token = Ruberto.cache.read(Authenticator.cache_key)

      assert_equal "refreshed_token", token
      assert_equal "refreshed_token", cached_token[:token]
    end

    def test_refresh_access_token_if_expired
      Ruberto.cache.write(Authenticator.cache_key, { token: "expired_token", expires_at: Time.now - 3600 })

      stub_token_request(access_token: "refreshed_token", expires_in: 3600)

      token = Authenticator.access_token
      cached_token = Ruberto.cache.read(Authenticator.cache_key)

      assert_equal "refreshed_token", token
      assert_equal "refreshed_token", cached_token[:token]
    end
  end
end
