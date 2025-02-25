# frozen_string_literal: true

require File.expand_path("../../test_helper", __dir__)

class DelvieryResourceTest < Minitest::Test
  def test_all
    stub_deliveries_request
    deliveries = Ruber::DeliveryResource.all

    assert_instance_of Ruber::Collection, deliveries
    assert_instance_of Ruber::Delivery, deliveries.data.first
    assert_equal "quote_id", deliveries.data.first.quote_id
  end

  def test_find
    stub_delivery_request
    delivery = Ruber::DeliveryResource.find("del_some_id")

    assert_instance_of Ruber::Delivery, delivery
    assert_equal "quote_id", delivery.quote_id
  end

  def test_create
    stub_delivery_creation_request
    delivery = Ruber::DeliveryResource.create(delivery_params)

    assert_instance_of Ruber::Delivery, delivery
    assert_equal "quote_id", delivery.quote_id
  end

  def test_cancel
    stub_delivery_cancellation_request
    delivery = Ruber::DeliveryResource.cancel("del_some_id")

    assert_instance_of Ruber::Delivery, delivery
    assert_equal "quote_id", delivery.quote_id
  end

  def test_proof_of_delivery
    stub_delivery_proof_of_delivery_request
    proof_of_delivery = Ruber::DeliveryResource.proof_of_delivery("del_some_id", proof_of_delivery_params)

    assert_instance_of Ruber::Delivery::ProofOfDelivery, proof_of_delivery
    assert_equal "document", proof_of_delivery.document
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

  def stub_delivery_creation_request
    stub_token_request
    stub_request(:post, %r{.*customers/#{Ruber.customer_id}/deliveries.*})
      .with(headers: { "Authorization" => "Bearer #{Ruber::Authenticator.access_token}" })
      .to_return(
        headers: { "Content-Type" => "application/json" },
        status: 200,
        body: File.new("test/fixtures/delivery.json").read
      )
  end

  def stub_delivery_cancellation_request
    stub_token_request
    stub_request(:post, %r{.*customers/#{Ruber.customer_id}/deliveries/.*})
      .with(headers: { "Authorization" => "Bearer #{Ruber::Authenticator.access_token}" })
      .to_return(
        headers: { "Content-Type" => "application/json" },
        status: 200,
        body: File.new("test/fixtures/delivery_cancel.json").read
      )
  end

  def stub_delivery_proof_of_delivery_request
    stub_token_request
    stub_request(:post, %r{.*customers/#{Ruber.customer_id}/deliveries/.*})
      .with(headers: { "Authorization" => "Bearer #{Ruber::Authenticator.access_token}" })
      .to_return(
        headers: { "Content-Type" => "application/json" },
        status: 200,
        body: File.new("test/fixtures/delivery_proof_of_delivery.json").read
      )
  end

  def stub_deliveries_request
    stub_token_request
    stub_request(:get, %r{.*customers/#{Ruber.customer_id}/deliveries})
      .with(headers: { "Authorization" => "Bearer #{Ruber::Authenticator.access_token}" })
      .to_return(
        headers: { "Content-Type" => "application/json" },
        status: 200,
        body: File.new("test/fixtures/deliveries.json").read
      )
  end

  def proof_of_delivery_params
    {
      "waypoint": "dropoff",
      "type": "picture"
    }
  end

  def delivery_params
    {
      pickup_name: "Store Name",
      pickup_address: "{\"street_address\":[\"100 Maiden Ln\"],\"city\":\"New York\",\"state\":\"NY\",\"zip_code\":\"10023\",\"country\":\"US\"}", # rubocop:disable Layout/LineLength
      pickup_phone_number: "+15555555555",
      dropoff_name: "Gordon Shumway",
      dropoff_address: "{\"street_address\":[\"30 Lincoln Center Plaza\"],\"city\":\"New York\",\"state\":\"NY\",\"zip_code\":\"10023\",\"country\":\"US\"}", # rubocop:disable Layout/LineLength
      dropoff_phone_number: "+15555555555",
      manifest_items: [
        {
          name: "Bow tie",
          quantity: 1,
          size: "small",
          dimensions: {
            "length": 20,
            "height": 20,
            "depth": 20
          },
          price: 100,
          weight: 300,
          vat_percentage: 1_250_000
        }
      ]
    }
  end
end
