# frozen_string_literal: true

require File.expand_path("../test_helper", __dir__)

module Ruberto
  class ObjectTest < Minitest::Test
    def test_creating_object_from_hash
      assert_equal "bar", Ruberto::Object.new(foo: "bar").foo
    end

    def test_nested_hash
      assert_equal "foobar", Ruberto::Object.new(foo: { bar: { baz: "foobar" } }).foo.bar.baz
    end

    def test_nested_number
      assert_equal 1, Ruberto::Object.new(foo: { bar: 1 }).foo.bar
    end

    def test_array
      object = Ruberto::Object.new(foo: [{ bar: :baz }])
      assert_equal :baz, object.foo.first.bar
    end

    def test_respond_with_ruberto_object
      assert_instance_of OpenStruct, Ruberto::Object.new(foo: { bar: "baz" }).foo
    end
  end
end
