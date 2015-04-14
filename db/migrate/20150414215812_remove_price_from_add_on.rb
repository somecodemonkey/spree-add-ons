class RemovePriceFromAddOn < ActiveRecord::Migration
  def change
    remove_column :spree_add_ons, :price
  end
end
