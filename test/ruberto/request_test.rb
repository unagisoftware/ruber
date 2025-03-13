# frozen_string_literal: true

require File.expand_path("../test_helper", __dir__)

module Ruberto
  class RequestTest < Minitest::Test
    def setup
      stub_token_request

      @request = Ruberto::Request.new("/test")
    end

    def test_get_success
      stub_request(:get, /.*test.*/)
        .to_return(
          status: 200,
          headers: { "Content-Type" => "application/json" },
          body: { message: "OK" }.to_json
        )

      response = @request.get

      assert_equal 200, response.status
      assert_equal "OK", response.body[:message]
    end

    def test_get_error
      stub_request(:get, /.*test/)
        .to_return(
          headers: { "Content-Type" => "application/json" },
          status: 400,
          body: {
            message: "Bad Request",
            metadata: { foo: "bar" }
          }.to_json
        )

      error = assert_raises(Ruberto::Error) { @request.get }
      assert_equal "Bad Request", error.message
      assert_equal "bar", error.metadata[:foo]
    end
  end
end
