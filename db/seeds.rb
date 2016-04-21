# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# Clear data
StockTicker.delete_all
DayPrice.delete_all

tickers = Hash.new
tickers["APPL"]  = StockTicker.create(code: 'APPL', description: 'Apple Inc.')
tickers["GOOG"]  = StockTicker.create(code: 'GOOG', description: 'Alphabet Inc.')
tickers["NASDAQ"]= StockTicker.create(code: 'NASDAQ', description: 'NASDAQ Composite')
tickers["GLD"]   = StockTicker.create(code: 'GLD', description: 'Gold')

# Current prices
codes = {'APPL' => 106.91, 'GOOG' => 753.93, 'NASDAQ' => 4940.33, 'GLD' => 1254.34}

today = Date.today
codes.each_pair do |code, price|
  (0..29).each do |diff|
    DayPrice.create(StockTicker: tickers[code], price: price, date: today - diff)
    # Randomly simulate prices, maximum deviation is 5%
    change = (rand(200) - 100).to_f / 100
    price += (price * 0.05 * change).round(4)
  end
end