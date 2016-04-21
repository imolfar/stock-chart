class StockTicker < ActiveRecord::Base
  has_many :DayPrice
  validates_uniqueness_of :code
end
