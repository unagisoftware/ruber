# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "ruber"

require "minitest/autorun"
require "webmock/minitest"

class Minitest::Test # rubocop:disable Style/ClassAndModuleChildren
  def setup
    Ruber.configuration.file_cache_path ||= File.join(Dir.tmpdir, "file_cache_test.yaml")

    super
  end
end
