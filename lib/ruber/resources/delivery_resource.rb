# frozen_string_literal: true

module Ruber
  class DeliveryResource
    class << self
      def find(id)
        response = Request.new("customers/#{Ruber.customer_id}/deliveries/#{id}").get

        Delivery.new response.body
      end
    end
  end
end
