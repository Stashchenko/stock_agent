# StockAgent

Enter stock name, start date or range of date.
 * return the stock prices
 * Calculate the return the stock has generated since the start date to today
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
```

## Run test

```
 $ bundle exec rspec
```