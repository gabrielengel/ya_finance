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
      response = fetch_v7("options/#{@ticker}")['optionChain']['result'][0]['options'][0]
      {
        puts: remap_options(response['puts']),
        calls: remap_options(response['calls']),
      }
    end

    private
    def remap_options(opts)
      opts.map{|opt|
        opt['expirationParsed'] = Time.at(opt['expiration']) unless opt['expiration'].nil?
        opt['lastTradeDateParsed'] = Time.at(opt['lastTradeDate']) unless opt['lastTradeDate'].nil?
        opt
      }
    end
  end
end
