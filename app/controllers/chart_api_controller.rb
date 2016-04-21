class ChartApiController < ApplicationController

  def getStockTickers
    # Provide only required data
    tickersList = StockTicker.select('id, code, description').order(code: :asc)
    render json: ChartApiResult.new("Ok", nil, tickersList)
  end

  def getLast30Days
    code = params["code"]

    ticker = StockTicker.find_by(code: code)
    if ticker === nil
      render json: ChartApiResult.new("Error", "No such Stock Ticker", nil)
      return
    end

    dayPrices = DayPrice.select('date, price').where(StockTicker: ticker).order(date: :asc).limit(30)
    result = []
    dayPrices.each do |dayPrice|
      result.push({date: dayPrice.date, price: dayPrice.price.to_f})
    end

    render json: ChartApiResult.new('Ok', nil, result)
  end
end


ChartApiResult = Struct.new(:status, :error, :result)