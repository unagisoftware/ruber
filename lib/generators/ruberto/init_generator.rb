# frozen_string_literal: true

require "rails/generators"

module Ruberto
  module Generators
    class InitGenerator < Rails::Generators::Base
      source_root File.expand_path("templates", __dir__)

      def add_initializer
        say "Copying Ruberto initializer"
        template "initializers/ruberto.tt", "config/initializers/ruberto.rb"
      end
    end
  end
end
