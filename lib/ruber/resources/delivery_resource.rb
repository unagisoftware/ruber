# frozen_string_literal: true

module Ruber
  class DeliveryResource
    class << self
      def all
        response = Request.new("customers/#{Ruber.customer_id}/deliveries").get

        Collection.from_response(response, type: Delivery)
      end

      def find(id)
        response = Request.new("customers/#{Ruber.customer_id}/deliveries/#{id}").get

        Delivery.new response.body
      end
    end
  end
end
