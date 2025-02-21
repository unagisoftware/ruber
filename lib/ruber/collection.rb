# frozen_string_literal: true

module Ruber
  class Collection
    attr_reader :data, :next_href

    def self.from_response(response, type:)
      body = response.body

      new(
        data: body[:data].map { |attrs| type.new(attrs) },
        next_href: body[:next_href]
      )
    end

    def initialize(data:, next_href:)
      @data = data
      @next_href = next_href
    end
  end
end
