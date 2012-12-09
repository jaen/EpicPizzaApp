class Ingredient < ActiveRecord::Base
  belongs_to :pizza

  attr_accessible :name,
  				  :price

  validates :name, :uniqueness => true
  validates :price, :presence => true,
  					:numericality => { :only_integer => true,
  									   :greater_than => 0 }
end
