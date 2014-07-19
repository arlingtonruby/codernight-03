require 'helper'

class TestApp < Minitest::Test

  def setup
    @app = App.new
  end

  def should_greet
      assert_equal "hello", @app.greeting
  end
end