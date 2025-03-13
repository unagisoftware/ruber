# frozen_string_literal: true

require File.expand_path("../../test_helper", __dir__)

class DeliveryResourceTest < Minitest::Test
  def test_all
    stub_deliveries_request
    deliveries = Ruberto::DeliveryResource.all

    assert_instance_of Ruberto::Collection, deliveries
    assert_instance_of Ruberto::Delivery, deliveries.data.first
    assert_equal "quote_id", deliveries.data.first.quote_id
  end

  def test_find
    stub_delivery_request
    delivery = Ruberto::DeliveryResource.find("del_some_id")

    assert_instance_of Ruberto::Delivery, delivery
    assert_equal "quote_id", delivery.quote_id
  end

  def test_create
    stub_delivery_creation_request
    delivery = Ruberto::DeliveryResource.create(create_params)

    assert_instance_of Ruberto::Delivery, delivery
    assert_equal "quote_id", delivery.quote_id
  end

  def test_cancel
    stub_delivery_cancellation_request
    delivery = Ruberto::DeliveryResource.cancel("del_some_id")

    assert_instance_of Ruberto::Delivery, delivery
    assert_equal "quote_id", delivery.quote_id
  end

  def test_update
    stub_delivery_update_request
    delivery = Ruberto::DeliveryResource.update("del_some_id", update_params)

    assert_instance_of Ruberto::Delivery, delivery
    assert_equal "The doorbell is not working. Knock on the door to the rhythm of Duraznito by Damas Gratis.",
                 delivery.pickup.notes
  end

  def test_proof_of_delivery
    stub_delivery_proof_of_delivery_request
    proof_of_delivery = Ruberto::DeliveryResource.proof_of_delivery("del_some_id", proof_of_delivery_params)

    assert_instance_of Ruberto::Delivery::ProofOfDelivery, proof_of_delivery
    assert_equal "document", proof_of_delivery.document
  end

  private

  def stub_delivery_request
    stub_token_request
    stub_request(:get, %r{.*customers/#{Ruberto.customer_id}/deliveries.*})
      .with(headers: { "Authorization" => "Bearer #{Ruberto::Authenticator.access_token}" })
      .to_return(
        headers: { "Content-Type" => "application/json" },
        status: 200,
        body: File.new("test/fixtures/delivery.json").read
      )
  end

  def stub_delivery_creation_request
    stub_token_request
    stub_request(:post, %r{.*customers/#{Ruberto.customer_id}/deliveries.*})
      .with(headers: { "Authorization" => "Bearer #{Ruberto::Authenticator.access_token}" })
      .to_return(
        headers: { "Content-Type" => "application/json" },
        status: 200,
        body: File.new("test/fixtures/delivery.json").read
      )
  end

  def stub_delivery_cancellation_request
    stub_token_request
    stub_request(:post, %r{.*customers/#{Ruberto.customer_id}/deliveries/.*})
      .with(headers: { "Authorization" => "Bearer #{Ruberto::Authenticator.access_token}" })
      .to_return(
        headers: { "Content-Type" => "application/json" },
        status: 200,
        body: File.new("test/fixtures/delivery_cancel.json").read
      )
  end

  def stub_delivery_proof_of_delivery_request
    stub_token_request
    stub_request(:post, %r{.*customers/#{Ruberto.customer_id}/deliveries/.*})
      .with(headers: { "Authorization" => "Bearer #{Ruberto::Authenticator.access_token}" })
      .to_return(
        headers: { "Content-Type" => "application/json" },
        status: 200,
        body: File.new("test/fixtures/delivery_proof_of_delivery.json").read
      )
  end

  def stub_delivery_update_request
    stub_token_request
    stub_request(:post, %r{.*customers/#{Ruberto.customer_id}/deliveries/.*})
      .with(headers: { "Authorization" => "Bearer #{Ruberto::Authenticator.access_token}" })
      .to_return(
        headers: { "Content-Type" => "application/json" },
        status: 200,
        body: File.new("test/fixtures/delivery_update.json").read
      )
  end

  def stub_deliveries_request
    stub_token_request
    stub_request(:get, %r{.*customers/#{Ruberto.customer_id}/deliveries})
      .with(headers: { "Authorization" => "Bearer #{Ruberto::Authenticator.access_token}" })
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

  def create_params
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

  def update_params
    {
      "dropoff_notes": "Second floor, black door to the right.",
      "dropoff_verification": {
        "barcodes": []
      },
      "manifest_reference": "REF0000002",
      "pickup_notes": "The doorbell is not working. Knock on the door to the rhythm of Duraznito by Damas Gratis.",
      "pickup_verification": {
        "barcodes": []
      },
      "requires_dropoff_signature": true,
      "requires_id": false,
      "tip_by_customer": 500,
      "dropoff_latitude": 40.7727076,
      "dropoff_longitude": -73.9839082,
      "pickup_ready_dt": "2024-12-12T14:00:00.000Z",
      "pickup_deadline_dt": "2024-12-12T14:30:00.000Z",
      "dropoff_ready_dt": "2024-12-12T14:30:00.000Z",
      "dropoff_deadline_dt": "2024-12-12T16:00:00.000Z"
    }
  end
end
