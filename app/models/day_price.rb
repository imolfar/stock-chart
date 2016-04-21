class DayPrice < ActiveRecord::Base
  belongs_to :StockTicker
  validates_uniqueness_of :date, scope: :StockTicker
end
