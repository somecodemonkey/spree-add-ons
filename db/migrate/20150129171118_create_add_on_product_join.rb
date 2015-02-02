class CreateAddOnProductJoin < ActiveRecord::Migration
  def change
    create_table :spree_add_ons_products do |t|
      t.integer :add_on_id
      t.integer :product_id

      t.index [:add_on_id, :product_id], :unique => true
      t.index [:product_id, :add_on_id], :unique => true
    end
  end
end
