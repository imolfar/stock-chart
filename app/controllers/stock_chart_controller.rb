class StockChartController < ApplicationController
  def homepage
    @tickersList = StockTicker.all.collect {|t| [ t.code + ' — ' + t.description, t.code ] }
  end
end
