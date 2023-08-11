require_relative 'helper'
require 'net/http'

class TestYaFinanceCurrent < Test::Unit::TestCase
  def setup
    @current = YaFinance::Current.new('VALE3.SA')
    @aapl = YaFinance::Current.new('AAPL')
  end
  def test_current_price
    VCR.use_cassette("current_price") do
      assert_equal(@current.price, ['BRL', 66.06])
    end
  end
  def test_current_market_cap
    VCR.use_cassette("current_price") do
      assert_equal(@current.market_cap, ['BRL', 286580801536])
    end
  end
  def test_current_holders
    VCR.use_cassette("current_holders") do
      assert_equal(@current.holders, {
        insiders_percent: 11.47,
        intitutions_percent: 46.82,
        institutions_float: 52.88,
        institutions_amount: 541
      }
    )
    end
  end
  def test_current_options
    VCR.use_cassette("current_options") do
      options = @aapl.options
      calls = options[:calls]
      putss = options[:puts]

      assert_equal(calls.size, 51)
      assert_equal(calls[0]['ask'], 127.95)
      assert_equal(calls[0]['bid'], 127.85)
      assert_equal(calls[0]['change'], -0.75)
      assert_equal(calls[0]['contractSize'], 'REGULAR')
      assert_equal(calls[0]['contractSymbol'], 'AAPL230811C00050000')
      assert_equal(calls[0]['currency'], 'USD')
      assert_equal(calls[0]['expiration'], 1691712000)
      assert_equal(calls[0]['expirationParsed'], Time.at(1691712000))
      assert_equal(calls[0]['impliedVolatility'], 1.0000000000000003e-05)
      assert_equal(calls[0]['inTheMoney'], true)
      assert_equal(calls[0]['lastPrice'], 127.45)
      assert_equal(calls[0]['lastTradeDate'], 1691773291)
      assert_equal(calls[0]['lastTradeDateParsed'], Time.at(1691773291))
      assert_equal(calls[0]['openInterest'], 1)
      assert_equal(calls[0]['percentChange'], -0.5850234)
      assert_equal(calls[0]['strike'], 50.0)
      assert_equal(calls[0]['volume'], 44)

      assert_equal(putss.size, 42)
      assert_equal(putss[0]['ask'], 0.01)
      assert_equal(putss[0]['bid'], 0.0)
      assert_equal(putss[0]['change'], 0.0)
      assert_equal(putss[0]['contractSize'], 'REGULAR')
      assert_equal(putss[0]['contractSymbol'], 'AAPL230811P00070000')
      assert_equal(putss[0]['currency'], 'USD')
      assert_equal(putss[0]['expiration'], 1691712000)
      assert_equal(putss[0]['expirationParsed'], Time.at(1691712000))
      assert_equal(putss[0]['impliedVolatility'], 5.500003124999999)
      assert_equal(putss[0]['inTheMoney'], false)
      assert_equal(putss[0]['lastPrice'], 0.01)
      assert_equal(putss[0]['lastTradeDate'], 1691435803)
      assert_equal(putss[0]['lastTradeDateParsed'], Time.at(1691435803))
      assert_equal(putss[0]['openInterest'], 2)
      assert_equal(putss[0]['percentChange'], 0.0)
      assert_equal(putss[0]['strike'], 70.0)
      assert_equal(putss[0]['volume'], 1)
    end
  end
end
