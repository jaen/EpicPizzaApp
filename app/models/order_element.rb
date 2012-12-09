class OrderElement < ActiveRecord::Base
  belongs_to :pizza
  belongs_to :order

  attr_accessible :order, :pizza, :quantity

  validates :quantity, :presence => true, :numericality => { :only_integer => true, :greater_than => 0 }
  validates :pizza, :presence => true
  validates :order, :presence => true

  def total_price
    quantity * pizza.price
  end
end
