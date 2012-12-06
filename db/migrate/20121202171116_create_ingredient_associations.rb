class CreateIngredientAssociations < ActiveRecord::Migration
  def change
    create_table :ingredient_associations do |t|
      t.references :pizza
      t.references :ingredient
      t.integer :quantity

      t.timestamps
    end
    add_index :ingredient_associations, :pizza_id
    add_index :ingredient_associations, :ingredient_id
  end
end
