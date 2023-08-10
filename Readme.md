# YaFinance

Financial information on stocks, funds, crypto and currencies from multiple sources, including and not limited to Yahoo Finance.

This wrapper was heavily inspired by (Ran Aroussi)[https://aroussi.com/]'s (yfinance)[https://pypi.org/project/yfinance/] python package.


## ☢️ IMPORTANT LEGAL DISCLAIMER
```
  # information sources

  Yahoo!, Y!Finance, and Yahoo! finance are registered trademarks of Yahoo, Inc.

  # ya_finance

  ya_finance is not affiliated, endorsed, or vetted by any of the information sources. It's an open-source tool that uses their publicly available APIs and HTML pages, and is intended for research and educational purposes.

  You should refer to each of the companies' terms of use for details on your rights to use the actual data downloaded.

  Remember: this gem is intended for personal use only.

  # limitation of liability

  The author is not responsible for the use or misuse of this code and the information collected from any of the sources.
```

(Contribute)[Contribute.md]
(YahooEndpoints)[YahooEndpoints.md]
(Find Tickers on Yahoo)[https://finance.yahoo.com/lookup/all?s=india]


# 📺 CLI usage
```sh
  yafin PETR4.SA current price # => ["BRL", 23.24]
```

# 🛣️ Roadmap

- [ ] Implement usage methods (see bellow)
- [ ] Implement query cache on Http class
- [ ] Allow threaded quering of multiple tickers
  - Something like `YaFinance.multiple(['VALE3.SA', 'PETR4.SA'], :current, :price)`

# 📦 Usage:

```ruby
ticker = YaFinance.new('AAPL')
ticker.current.price # => ✅ ['USD', 23.50]
ticker.current.holders # => 🟡 @TODO: organize repsonse
ticker.current.options # => ✅ [contracts]
ticker.current.market_cap #=> ✅ ["USD",2862466203648]

ticker.meta.short_name # => ✅ "Apple Inc."
ticker.meta.shares # 🟡 @TODO
ticker.meta.info # 🟡 @TODO
ticker.meta.sustainability # 🟡 @TODO
ticker.meta.earnings_calendar # => ✅ [{date, estimate, reported, surprise}]

ticker.past.history # => 🟡 @TODO: Process
ticker.past.dividends # => ✅ [{"2018-08-10":0.1825},{"2019-02-08":0.1825},...]
ticker.past.capital_gains # => @TODO
ticker.past.splits # => 🟡 @TODO: Process hash
ticker.past.actions # => 🟡 @TODO: dividends + capital_gains + splits @TODO

ticker.quarterly.income_statement # => 🟡 @TODO: implement search
ticker.quarterly.balance_sheet # => 🟡 @TODO
ticker.quarterly.cashflow # => 🟡 @TODO
ticker.quarterly.earnings # => 🟡 @TODO

ticker.yearly.income_statement # 🟡 @TODO: Same as quarterly
ticker.yearly.balance_sheet # => 🟡 @TODO
ticker.yearly.cashflow # => 🟡 @TODO
ticker.yearly.earnings # => 🟡 @TODO
```

