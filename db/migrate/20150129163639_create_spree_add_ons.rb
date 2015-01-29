class CreateSpreeAddOns < ActiveRecord::Migration
  def change
    create_table :spree_add_ons do |t|
      t.string      :name,            null: false
      t.text        :description
      t.string      :sku,             null: false,    unique: true
      t.boolean     :active,          null: false,    default: true
      t.decimal     :price,           precision: 10,  scale: 2,     null: false

      t.datetime    :deleted_at
      t.datetime    :created_at,      null: false
      t.datetime    :updated_at,      null: false
    end
  end
end
