module Ruber
  class Configuration
    attr_accessor :customer_id, :client_id, :client_secret
  end

  class << self
    attr_reader :configuration

    def configuration
      @configuration ||= Configuration.new
    end

    def configuration=(config)
      @configuration = config
    end

    def configure
      yield configuration
    end
  end
end
