require_relative 'http'

class YaFinance
  class Meta
    include Http::FetchV6
    include Http::FetchRoot

    def initialize(ticker, options={})
      @ticker = ticker
      @options = options
    end

    def earnings_calendar
      html = fetch_root("calendar/earnings?symbol=#{@ticker}&offset=0&size=1000")
      YaFinance::Scrapper::Calendar.process(html)
    end

    def short_name
      fetch_v6('price')['price']['shortName']
    end

    def statistics
      fetch_v6('defaultKeyStatistics')['defaultKeyStatistics']
    end

    def financial
      fetch_v6('financialData')['financialData']
    end

    def summary
      fetch_v6('summaryDetail')['summaryDetail']
    end

    def profile
      fetch_v6('assetProfile')['assetProfile']
    end

    def quote_type
      fetch_v6('quoteType')['quoteType']
    end
  end
end
