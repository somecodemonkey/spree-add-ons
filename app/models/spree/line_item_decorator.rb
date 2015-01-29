Spree::LineItem.class_eval do

  after_create :adjust_add_ons
  after_update :adjust_add_ons

  def add_ons
    product.add_ons
  end

  def adjust_add_ons
    add_ons.each {|add_on| add_on.adjust(self)}
  end

end