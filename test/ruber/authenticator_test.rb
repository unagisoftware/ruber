# frozen_string_literal: true

require "test_helper"
require "webmock/minitest"

module Ruber
  class AuthenticatorTest < Minitest::Test
    include WebMock::API

    def setup
      Ruber.cache.clear
    end

    def test_access_token_fetches_and_caches_token
      stub_token_request(access_token: "new_token", expires_in: 3600)

      token = Authenticator.access_token
      cached_token = Ruber.cache.read(Ruber.cache_key)

      assert_equal "new_token", token
      assert_equal "new_token", cached_token
    end

    def test_refresh_access_token_forces_new_token
      Ruber.cache.write(Ruber.cache_key, "old_token")

      stub_token_request(access_token: "refreshed_token", expires_in: 3600)

      token = Authenticator.refresh_access_token
      cached_token = Ruber.cache.read(Ruber.cache_key)

      assert_equal "refreshed_token", token
      assert_equal "refreshed_token", cached_token
    end

    private

    def stub_token_request(access_token:, expires_in:)
      stub_request(:post, Authenticator::OAUTH_URL)
        .to_return(
          status: 200,
          body: {
            access_token: access_token,
            expires_in: expires_in
          }.to_json
        )
    end
  end
end
