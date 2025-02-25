# frozen_string_literal: true

module Ruber
  class DeliveryResource
    class << self
      def all
        response = Request.new("customers/#{Ruber.customer_id}/deliveries").get

        Collection.from_response(response.body, type: Delivery)
      end

      def find(id)
        response = Request.new("customers/#{Ruber.customer_id}/deliveries/#{id}").get

        Delivery.new response.body
      end

      def create(params)
        response = Request.new("customers/#{Ruber.customer_id}/deliveries").post(body: params)

        Delivery.new response.body
      end

      def cancel(id)
        response = Request.new("customers/#{Ruber.customer_id}/deliveries/#{id}/cancel").post

        Delivery.new response.body
      end

      def update(id, params)
        response = Request.new("customers/#{Ruber.customer_id}/deliveries/#{id}").post(body: params)

        Delivery.new response.body
      end

      def proof_of_delivery(id, params)
        response = Request.new("customers/#{Ruber.customer_id}/deliveries/#{id}/proof_of_delivery").post(body: params)

        Delivery::ProofOfDelivery.new response.body
      end
    end
  end
end
