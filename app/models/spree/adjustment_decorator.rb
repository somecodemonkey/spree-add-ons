module Spree
  Adjustment.class_eval do

    scope :add_ons, -> { where(source_type: 'Spree::AddOn') }

  end
end