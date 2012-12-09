class Pizza < ActiveRecord::Base
      has_many :ingredient_associations, :dependent => :destroy, :before_add => :set_nested
      has_many :ingredients, :through => :ingredient_associations
      has_many :orders, :dependent => :destroy

      attr_accessible :name,
      					      :description,
      					      :ingredient_associations_attributes

      accepts_nested_attributes_for :ingredient_associations, :allow_destroy => true

      validates :name, :presence => true
      validates :description, :presence => true

      scope :currently_ordered_of_type, lambda { |pizza|
        where(:name => pizza.name, :status_cd => Order.open)
      }

      def price
      	ingredient_associations.reduce(0) { |acc, i| acc += (i.id ? i.total_price : 0) }
      end

    private
      def set_nested(ingredient_associations)
        ingredient_associations.pizza ||= self
      end
end
