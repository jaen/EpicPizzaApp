class CreateOrderElements < ActiveRecord::Migration
  def change
    create_table :order_elements do |t|
      t.references :order
      t.references :pizza
      t.integer :quantity

      t.timestamps
    end
  end
end
