# frozen_string_literal: true

require "faraday"
require "faraday/net_http_persistent"

module Ruber
  class Request
    BASE_URL = "https://api.uber.com/v1"

    def initialize(url)
      @url = url
    end

    def get(params: {})
      handle_response connection.get(@url, params)
    end

    def post(body: {}, headers: {})
      handle_response connection.post(@url, body, headers)
    end

    def patch(body:, headers: {})
      handle_response connection.patch(@url, body, headers)
    end

    def put(body:, headers: {})
      handle_response connection.put(@url, body, headers)
    end

    def delete(params: {}, headers: {})
      handle_response connection.delete(@url, params, headers)
    end

    private

    def connection
      @connection ||= Faraday.new do |conn|
        conn.url_prefix = BASE_URL
        conn.request :authorization, :Bearer, Ruber::Authenticator.access_token
        conn.request :json
        conn.response :json, content_type: "application/json", parser_options: { symbolize_names: true }
      end
    end

    def handle_response(response)
      return response if response.status == 200

      raise Ruber::Error.new(response.body[:message], response.body, response.status)
    end
  end
end
