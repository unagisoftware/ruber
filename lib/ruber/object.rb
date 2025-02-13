# frozen_string_literal: true

module Ruber
  class Object
    attr_reader :data

    def initialize(attributes)
      @data = to_data_object(attributes)
    end

    def to_data_object(obj)
      if obj.is_a?(Hash)
        wrapped = obj.transform_values { |val| to_data_object(val) }

        Data.define(*wrapped.keys).new(**wrapped)
      elsif obj.is_a?(Array)
        obj.map { |o| to_data_object(o) }
      else
        obj
      end
    end

    private

    def method(name)
      super unless @data.respond_to?(name)

      @data.public_send(name)
    end

    def method_missing(name, *args)
      super unless @data.respond_to?(name)

      result = @data.public_send(name, *args)

      result.is_a?(Data) ? self.class.new(result.to_h) : result
    end

    def respond_to_missing?(name, *args) = @data.respond_to?(name) || super
  end
end
