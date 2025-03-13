# frozen_string_literal: true

module Ruberto
  class Error < StandardError
    attr_reader :status, :message, :metadata

    def initialize(msg, body, status)
      @message = body[:message]
      @metadata = body[:metadata]
      @status = status

      super(msg)
    end
  end
end
