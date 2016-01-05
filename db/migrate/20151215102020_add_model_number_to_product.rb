class AddModelNumberToProduct < ActiveRecord::Migration
  def change
  	add_column :spree_products, :model_number, :string
  end
end
