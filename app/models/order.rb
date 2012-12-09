class Order < ActiveRecord::Base
  belongs_to :user
  has_many :order_elements, :dependent => :destroy, :before_add => :set_nested
  has_many :pizzas, :through => :order_elements
  attr_accessible :quantity, :status

  as_enum :status, [:open, :made, :paid, :closed]

  scope :currently_open, where(:status_cd => Order.open)

  def total_price
  	order_elements.reduce(0) { |acc, i| acc += i.total_price }
  end

private
  def set_nested(order_elements)
    order_elements.order ||= self
  end
end
