class AddTypeToUser < ActiveRecord::Migration
  def change
  	add_column :users, :type_cd, :integer, :default => 0
  end
end
