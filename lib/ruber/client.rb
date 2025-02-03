require "faraday"
require "faraday_middleware"

module Ruber
  class Client
    BASE_URL = "https://api.uber.com/v1.2"
    
    attr_reader :client_secret, :adapter

    def initialize(client_secret:, adapter: Faraday.default_adapter)
      @client_secret = client_secret
      @adapter = adapter
    end

    def connection
      @connection ||= Faraday.new do |conn|
        conn.url_prefix = BASE_URL
        conn.request :json
        conn.response :json, content_type: 'application/json'
        conn.adapter adapter
      end
    end
  end
end

