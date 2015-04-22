class AddOptionTypesAndValues < ActiveRecord::Migration
  def change

    create_table :spree_option_types_add_ons, :id => false do |t|
      t.references :add_on
      t.references :option_type
    end

    create_table :spree_option_values_add_ons, :id => false do |t|
      t.references :add_on
      t.references :option_value
    end

    add_index :spree_option_values_add_ons, [:add_on_id, :option_value_id], :name => 'index_option_values_add_ons_on_add_on_id_and_option_value_id'
    add_index :spree_option_values_add_ons, [:add_on_id],                   :name => 'index_spree_option_values_add_ons_on_add_on_id'

  end
end
