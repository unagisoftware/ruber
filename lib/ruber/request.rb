# frozen_string_literal: true

require "faraday"
require "faraday_middleware"

module Ruber
  class Request
    BASE_URL = "https://api.uber.com/v1"

    def initialize(url)
      @url = url
    end

    def get
      handle_response connection.get(@url)
    end

    def post(body:, headers: {})
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
        conn.adapter Faraday.default_adapter
      end
    end

    def handle_response(response)
      case response.status
      when 400
        raise Error, "Your request was malformed. #{response.body["error"]}"
      when 401
        raise Error, "You did not supply valid authentication credentials. #{response.body["error"]}"
      when 403
        raise Error, "You are not allowed to perform that action. #{response.body["error"]}"
      when 404
        raise Error, "No results were found for your request. #{response.body["error"]}"
      when 429
        raise Error, "Your request exceeded the API rate limit. #{response.body["error"]}"
      when 500
        raise Error, "We were unable to perform the request due to server-side problems. #{response.body["error"]}"
      when 503
        raise Error,
              "You have been rate limited for sending more than 20 requests per second. #{response.body["error"]}"
      end

      response
    end
  end
end
