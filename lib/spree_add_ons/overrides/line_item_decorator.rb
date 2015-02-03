Spree::LineItem.class_eval do

  class_attribute :price_modifier_hooks
  self.price_modifier_hooks = Set.new

  def discounted_amount
    amount + hook_totals
  end

  def hook_totals
    price_modifier_hooks.map { |hook|
      self.send(hook)
    }.sum
  end

  def self.register_price_modifier_hook(hook)
    self.price_modifier_hooks.add(hook)
  end

end