# frozen_string_literal: true

require "faraday"
require "json"

module Ruber
  class Authenticator
    OAUTH_URL = "https://auth.uber.com/oauth/v2/token"
    GRANT_TYPE = "client_credentials"
    SCOPE = "eats.deliveries"

    class << self
      def access_token
        Ruber.cache.read(Ruber.cache_key) || fetch_new_token
      end

      def refresh_access_token
        Ruber.cache.delete(Ruber.cache_key)

        fetch_new_token
      end

      private

      def fetch_new_token
        response = Faraday.post(
          OAUTH_URL,
          {
            client_id: Ruber.client_id,
            client_secret: Ruber.client_secret,
            grant_type: GRANT_TYPE,
            scope: SCOPE
          }
        )

        data = JSON.parse(response.body.to_s)

        Ruber.cache.write(Ruber.cache_key, data["access_token"], expires_in: data["expires_in"].to_i)

        @access_token = data["access_token"]
      end
    end
  end
end
