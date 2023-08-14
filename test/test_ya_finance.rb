require_relative 'helper'

class TestYaFinance < Test::Unit::TestCase
  def test_class_loaded
    assert_equal(YaFinance.class, Class)
  end
  def test_initialize_with_ticker
    assert(YaFinance.new('VALE3.SA').methods.include?(:current))
  end
end
