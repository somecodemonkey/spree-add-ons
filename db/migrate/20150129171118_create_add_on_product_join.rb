class CreateAddOnProductJoin < ActiveRecord::Migration
  def change
    create_join_table :spree_add_ons, :spree_products do |t|
      t.integer :add_on_id
      t.integer :product_id

      t.index [:add_on_id, :product_id]
      t.index [:product_id, :add_on_id]
    end
  end
end
