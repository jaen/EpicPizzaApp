class Ingredient < ActiveRecord::Base
  belongs_to :pizza

  attr_accessible :name,
  				  :price

  validates :name, :uniqueness => true
end
