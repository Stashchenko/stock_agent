# StockAgent

Enter stock name, start date or range of date.
 * return the stock prices
 * Calculate the return the stock has generated since the start date + 5 days
 * The maximum drawdown of the stock within that time frame.

## Installation

```bash
 $ git@github.com:Stashchenko/stock_agent.git
 $ bin/setup
```

You can use [direnv](https://direnv.net/) as well in order to config ENV variables.


## Usage

```
 $ ruby stock.rb STOCK_SYMBOL START_DATE END_DATE
 #example
 $ ruby stock.rb AAPL 2018-01-02
 # Out 
Stock by day:
 2018-01-02: Closed at 172.26 (169.26 ~ 172.3)
 2018-01-03: Closed at 172.23 (171.96 ~ 174.55)
 2018-01-04: Closed at 173.03 (172.08 ~ 173.47)
 2018-01-05: Closed at 175.0 (173.05 ~ 175.37)
 
Drawdowns: by date:
 1.8% (172.3 on 2018-01-02-> 169.26 on 2018-01-02)
 0.9% (174.55 on 2018-01-03-> 172.08 on 2018-01-04)
 1.3% (175.37 on 2018-01-05-> 173.05 on 2018-01-05)
 Maximum drawdown: 1.8% (172.3 on 2018-01-02-> 169.26 on 2018-01-02)
 
Return: 2.740000000000009 [1.6%] (172.26 on 2018-01-02 -> 175.0 on 2018-01-05)
```

## Run test

```
 $ bundle exec rspec
```

## TODO
 * Coverage for all classes   
 * response.rb should have abstract class with clear structure response in order to provide adapters compatibility 
 * renderer.rb may be split by 2 classes, notifiers responsibility might be in lowest level  