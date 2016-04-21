class CreateStockTickers < ActiveRecord::Migration
  def change
    create_table :stock_tickers do |t|
      t.string :code
      t.string :description

      t.timestamps
    end
  end
end
