require_relative 'helper'
require 'net/http'

class TestYaFinanceMeta < Test::Unit::TestCase
  def setup
    @aapl = YaFinance::Meta.new('AAPL')
  end
  def test_earnings_calendar
    VCR.use_cassette("meta_earnings_calendar") do
      calendar = @aapl.earnings_calendar
      first_event = calendar[-1]
      assert_equal(Date.parse("1999-01-13"), first_event[:date].to_date)
      assert_equal('0.01', first_event[:estimate])
      assert_equal('0.01', first_event[:reported]) # @TODO: what?
      assert_equal('+12.62', first_event[:surprise])
    end
  end
  def test_short_name
    VCR.use_cassette("meta_short_name") do
      assert_equal("Apple Inc.", @aapl.short_name)
    end
  end
  def test_statistics
    VCR.use_cassette("meta_statistics") do
      stats = @aapl.statistics
      assert_equal(0.026560426, stats['52WeekChange']['raw'])
      assert_equal(1.286802, stats['beta']['raw'])
    end
  end
  def test_financial
    VCR.use_cassette("meta_financial") do
      financial = @aapl.financial
      assert_equal('buy', financial['recommendationKey'])
      assert_equal(0.814, financial['quickRatio']['raw'])
      assert_equal(181.305, financial['debtToEquity']['raw'])
      assert_equal(0.05, financial['earningsGrowth']['raw'])
    end
  end
  def test_summary
    VCR.use_cassette("meta_summary") do
      summary = @aapl.summary
      assert_equal(0.0054, summary['dividendYield']['raw'])
      assert_equal(0.156, summary['payoutRatio']['raw'])
      assert_equal(1000, summary['bidSize']['raw'])
      assert_equal(800, summary['askSize']['raw'])
      assert_equal(124.17, summary['fiftyTwoWeekLow']['raw'])
      assert_equal(198.23, summary['fiftyTwoWeekHigh']['raw'])
      assert_equal(187.4426, summary['fiftyDayAverage']['raw'])
      assert_equal("2023-05-12", summary['exDividendDate']['fmt'])
    end
  end
  def test_profile
    VCR.use_cassette("meta_profile") do
      profile = @aapl.profile
      assert_equal("One Apple Park Way", profile['address1'])
      assert_equal("United States", profile['country'])
      assert_equal("https://www.apple.com", profile['website'])
      assert_equal("Technology", profile['sector'])
      assert_equal("Mr. Timothy D. Cook", profile['companyOfficers'][0]['name'])
      assert_equal("CEO & Director", profile['companyOfficers'][0]['title'])
      assert_match(/designs, manu/, profile["longBusinessSummary"])
    end
  end
  def test_quote_type
    VCR.use_cassette("meta_quote_type") do
      quote = @aapl.quote_type
      assert_equal("NMS", quote["exchange"])
      assert_equal("EQUITY", quote["quoteType"])
      assert_equal("AAPL", quote["symbol"])
      assert_equal("AAPL", quote["underlyingSymbol"])
      assert_equal("Apple Inc.", quote["shortName"])
      assert_equal("Apple Inc.", quote["longName"])
      assert_equal(345479400, quote["firstTradeDateEpochUtc"])
      assert_equal("America/New_York", quote["timeZoneFullName"])
      assert_equal("EDT", quote["timeZoneShortName"])
      assert_equal("finmb_24937", quote["messageBoardId"])
      assert_equal(-14400000, quote["gmtOffSetMilliseconds"])
    end
  end
end
