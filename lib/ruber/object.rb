# frozen_string_literal: true

module Ruber
  class Object
    def initialize(attributes)
      @data = to_data_object(attributes)
    end

    def to_data_object(obj)
      if obj.is_a?(Hash)
        wrapped = obj.transform_values do |val|
          result = to_data_object(val)

          result.is_a?(Data) ? self.class.new(result.to_h) : result
        end

        Data.define(*wrapped.keys).new(**wrapped)
      elsif obj.is_a?(Array)
        obj.map { |o| to_data_object(o) }
      else
        obj
      end
    end

    private

    def method_missing(name, *args)
      super unless @data.respond_to?(name)

      @data.public_send(name, *args)
    end

    def respond_to_missing?(name, *args) = @data.respond_to?(name) || super
  end
end
