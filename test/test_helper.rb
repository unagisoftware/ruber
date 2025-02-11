# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)

require "minitest/autorun"
require "webmock/minitest"

require "ruber"

class Minitest::Test # rubocop:disable Style/ClassAndModuleChildren
  def before_setup
    super

    Ruber.configuration.file_cache_path = "file_cache_test.yaml"
  end
end
