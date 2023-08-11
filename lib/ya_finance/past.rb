class YaFinance::Past
  include YaFinance::Http::FetchV8
  include YaFinance::Http::FetchRoot

  ALL_EVENTS='div,splits,capitalGains'
  OPTIONS='&includePrePost=False&interval=1d&range=5y'

  def initialize(ticker, options)
    @ticker = ticker
    @options = options
  end

  # chart/GOOGL?events=&includePrePost=False&interval=1d&range=1y

  def history
    fetch_v8("chart/#{@ticker}?events=#{ALL_EVENTS}")['chart']['result'][0]
    # @TODO: map timestamps
  end
  def dividends
    evs = fetch_v8("chart/#{@ticker}?events=div#{OPTIONS}")['chart']['result'][0]['events']['dividends']
    response = []
    evs.map{|k,v| response.push({ "#{Date.parse(Time.at(v['date']).to_s)}" => v['amount'] })}
    response
  end

  def splits
    evs = fetch_v8("chart/#{@ticker}?events=splits#{OPTIONS}")['chart']['result'][0]['events']['splits']
    response = []
    # {"1598880600"=>{"date"=>1598880600, "numerator"=>4.0, "denominator"=>1.0, "splitRatio"=>"4:1"}}
    evs.map{|k,v| response.push({ "#{Date.parse(Time.at(v['date']).to_s)}" => v['amount'] })}
    response
  end

  def capital_gains
    evs = fetch_v8("chart/#{@ticker}?events=capitalGains#{OPTIONS}")['chart']['result'][0]['events']
  end

  def actions
    # ...
  end
end
