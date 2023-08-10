require_relative 'http'

class YaFinance
  class Meta
    include Http::FetchV6
    include Http::FetchRoot

    def initialize(ticker, options)
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

    def shares
      # ...
    end

    def info
      # ...
    end

    def sustainability
      # ...
    end
  end
end
