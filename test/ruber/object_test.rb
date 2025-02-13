# frozen_string_literal: true

require File.expand_path("../test_helper", __dir__)

module Ruber
  class ObjectTest < Minitest::Test
    def test_creating_object_from_hash
      assert_equal "bar", Ruber::Object.new(foo: "bar").foo
    end

    def test_nested_hash
      assert_equal "foobar", Ruber::Object.new(foo: { bar: { baz: "foobar" } }).foo.bar.baz
    end

    def test_nested_number
      assert_equal 1, Ruber::Object.new(foo: { bar: 1 }).foo.bar
    end

    def test_array
      object = Ruber::Object.new(foo: [{ bar: :baz }])
      assert_equal :baz, object.foo.first.bar
    end

    def test_respond_to_missing
      assert_respond_to Ruber::Object.new(foo: "bar"), :foo
    end

    def test_invalid_method
      assert_raises(NoMethodError) { Ruber::Object.new(foo: "bar").invalid }
    end

    def test_respond_with_ruber_object
      assert_instance_of Ruber::Object, Ruber::Object.new(foo: { bar: "baz" }).foo
    end
  end
end
