class CreateAddOnOptions < ActiveRecord::Migration
  def change
    remove_column :spree_add_ons, :price
    add_column :spree_add_ons, :master_id, :integer
    add_column :spree_add_ons, :preferences, :text
    add_column :spree_add_ons, :is_master, :boolean, default: false
    change_column_null :spree_add_ons, :sku, true
    change_column_null :spree_add_ons, :active, true
  end
end
