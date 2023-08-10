require_relative 'helper'
class TestYaFinanceCurrent < Test::Unit::TestCase
  def setup
    @current = YaFinance::Current.new('VALE3.SA')
  end
  def test_current_price
    assert_equal(@current.price, 23.40)
  end
  def test_current_holders
    assert_equal(@current.holders, {})
  end
  def test_current_options
    assert_equal(@current.options, [])
  end
end
