# frozen_string_literal: true

require File.expand_path("../../test_helper", __dir__)

class DelvieryResourceTest < Minitest::Test
  def test_find
    stub_delivery_request
    delivery = Ruber::DeliveryResource.find('del_some_id')

    assert_equal Ruber::Delivery, delivery.class
    assert_equal "quote_id", delivery.quote_id
  end

  private

  def stub_delivery_request
    stub_token_request
    stub_request(:get, %r{.*customers/#{Ruber.customer_id}/deliveries.*})
      .with(headers: { "Authorization" => "Bearer #{Ruber::Authenticator.access_token}" })
      .to_return(
        headers: { "Content-Type" => "application/json" },
        status: 200,
        body: File.new("test/fixtures/delivery.json").read
      )
  end
end
