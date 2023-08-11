require 'excon'
class YaFinance::Http
  ROOT_URL = 'https://finance.yahoo.com/'
  QUERY_URL = "https://query2.finance.yahoo.com"
  HISTORICAL_URL = "#{ROOT_URL}quote"
  V8_URL = "#{QUERY_URL}/v8/finance"
  V7_URL = "#{QUERY_URL}/v7/finance"
  V6_URL = "#{QUERY_URL}/v6/finance/quoteSummary"
  CHART_URL = 'https://ichart.finance.yahoo.com/x'
  FUNDAMENTALS_URL = "#{QUERY_URL}/ws/fundamentals-timeseries/v1/finance/timeseries" # {0}?symbol={0}


  def self.fetch(uri)
    Excon.get(uri.to_s, persistent: true, headers: {"User-Agent" => "YaFin/#{YaFinance::VERSION}"})
  end

  module FetchRoot
    def fetch_root(path)
      uri = URI("#{ROOT_URL}/#{path}")
      YaFinance::Http.fetch(uri).body
    end
  end

  module FetchHistorical
    def fetch_historical(path)
      uri = URI("#{HISTORICAL_URL}/#{path}")
      YaFinance::Http.fetch(uri).body
    end
  end

  module FetchFundamentals
    def fetch_fundamentals(path)
      uri = URI("#{FUNDAMENTALS_URL}/#{path}")
      YaFinance::Http.fetch(uri).body
    end
  end

  module FetchV7
    def fetch_v7(path)
      uri = URI("#{V7_URL}/#{path}")
      JSON.parse(YaFinance::Http.fetch(uri).body)
    end
  end
  module FetchV8
    def fetch_v8(path)
      uri = URI("#{V8_URL}/#{path}")
      JSON.parse(YaFinance::Http.fetch(uri).body)
    end
  end

  module FetchV6
    def fetch_v6(mod)
      # modules = ['financialData', 'quoteType', 'defaultKeyStatistics', 'assetProfile', 'summaryDetail']
      uri = URI("#{V6_URL}/#{ERB::Util.url_encode(@ticker)}?modules=#{mod}")
      json = JSON.parse(YaFinance::Http.fetch(uri).body)

      if json["quoteSummary"] && json["quoteSummary"]["error"]
        return json["quoteSummary"]["error"]
      end

      result = json["quoteSummary"]&.dig("result", 0)
      return nil if result.nil?

      result
    rescue Net::HTTPBadResponse, Net::HTTPNotFound, Net::HTTPError, Net::HTTPServerError, JSON::ParserError
      return "HTTP Error"
    end
  end
end
