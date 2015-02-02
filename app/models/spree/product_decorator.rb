Spree::Product.class_eval do

  has_and_belongs_to_many :add_ons

  validate :unique_add_ons

  def unique_add_ons
    errors.add(:unique_add_ons, Spree.t(:unique_add_ons)) if add_ons.detect {|e| add_ons.rindex(e) != add_ons.index(e) }
  end

end