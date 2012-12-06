class Pizza < ActiveRecord::Base
  has_many :ingredient_associations, :dependent => :destroy
  has_many :ingredients, :through => :ingredient_associations

  attr_accessible :name,
  					      :description,
  					      :ingredient_associations_attributes

  accepts_nested_attributes_for :ingredient_associations, :allow_destroy => true

  validates :name, :presence => true

  def price
  	ingredient_associations.reduce(0) { |acc, i| acc += i.total_price }
  end
end
