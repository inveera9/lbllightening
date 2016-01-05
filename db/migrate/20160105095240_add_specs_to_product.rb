class AddSpecsToProduct < ActiveRecord::Migration
  def change
    add_column :spree_products, :specs, :text
  end
end
