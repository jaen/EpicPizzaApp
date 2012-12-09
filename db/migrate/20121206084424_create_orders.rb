class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :user
      t.integer :status_cd, :default => 0

      t.timestamps
    end
    add_index :orders, :user_id
    add_index :orders, :pizza_id
  end
end
