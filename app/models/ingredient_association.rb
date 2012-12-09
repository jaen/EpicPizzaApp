class IngredientAssociation < ActiveRecord::Base
  belongs_to :pizza
  belongs_to :ingredient

  attr_accessible :quantity,
  				  :pizza_id,
  				  :ingredient_id

  validates :quantity, :presence => true,
                       :numericality => { :only_integer => true,
                                          :greater_than => 0 }
  validates :pizza, :presence => true
  validates :ingredient, :presence => true

  def total_price
  	quantity * ingredient.price
  end
end
