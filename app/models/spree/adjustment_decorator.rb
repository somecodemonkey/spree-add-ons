module Spree
  Adjustment.class_eval do

    scope :add_ons, -> { where(source_type: Spree::AddOn.subclasses.map{|c| c.name}.push("Spree::AddOn")) }

  end
end