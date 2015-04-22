Spree::OptionType.class_eval do

  has_and_belongs_to_many :add_ons, join_table: 'spree_option_types_add_ons'

end