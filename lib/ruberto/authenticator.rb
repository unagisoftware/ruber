# frozen_string_literal: true

require "json"

module Ruberto
  class Authenticator
    OAUTH_URL = "https://auth.uber.com/oauth/v2/token"
    GRANT_TYPE = "client_credentials"
    SCOPE = "eats.deliveries"

    class << self
      def access_token
        @access_token = cached_token&.fetch(:token) || fetch_new_token

        @access_token = refresh_access_token if token_expired?

        @access_token
      end

      def refresh_access_token
        Ruberto.cache.delete(cache_key)

        fetch_new_token
      end

      def cache_key
        @cache_key ||= "#{Ruberto.customer_id}_#{Ruberto.client_id}_access_token"
      end

      private

      def token_expired?
        cached_token[:expires_at] < Time.now
      end

      def cached_token
        Ruberto.cache.read(cache_key)
      end

      def fetch_new_token
        response = Faraday.post(
          OAUTH_URL,
          {
            client_id: Ruberto.client_id,
            client_secret: Ruberto.client_secret,
            grant_type: GRANT_TYPE,
            scope: SCOPE
          }
        )

        data = JSON.parse(response.body.to_s)

        expires_at = Time.now + data["expires_in"].to_i
        Ruberto.cache.write(cache_key, { token: data["access_token"], expires_at: expires_at })

        data["access_token"]
      end
    end
  end
end
