require 'erb'
require_relative 'http'

class YaFinance
  class Current
    include Http::FetchV6
    include Http::FetchV7
    include Http::FetchHistorical

    def initialize(ticker, options={})
      @ticker = ticker
      @options = options
    end
    def price
      pris = fetch_v6('price')['price']
      [pris['currency'], pris['regularMarketPrice']['raw']]
    end
    def market_cap
      pris = fetch_v6('price')['price']
      [pris['currency'], pris['marketCap']['raw']]
    end
    def holders
      response = fetch_historical("#{@ticker}/holders")
      YaFinance::Scrapper::Holders.process(response)
    end
    def options
      fetch_v7("options/#{@ticker}")['optionChain']['result'][0]['options']
    end

    private

  end
end
