# frozen_string_literal: true

require "rails/generators"

module Ruber
  module Generators
    class InitGenerator < Rails::Generators::Base
      source_root File.expand_path("templates", __dir__)

      def add_initializer
        say "Copying Ruber initializer"
        template "initializers/ruber.tt", "config/initializers/ruber.rb"
      end
    end
  end
end
