class CreateDayPrices < ActiveRecord::Migration
  def change
    create_table :day_prices do |t|
      t.references :StockTicker, index: true
      t.date :date
      t.decimal :price, precision: 12, scale: 4
      t.index [:StockTicker_id, :date], unique: true
    end
  end
end
