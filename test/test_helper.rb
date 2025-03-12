# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)

require "minitest/autorun"
require "webmock/minitest"
require "support/helpers"
require "minitest/reporters"
Minitest::Reporters.use!

require "ruber"

class Minitest::Test # rubocop:disable Style/ClassAndModuleChildren
  include TestHelpers

  def before_setup
    super

    Ruber.configuration.customer_id = "a_customer_id"
    Ruber.configuration.client_secret = "a_client_secret"
  end
end
