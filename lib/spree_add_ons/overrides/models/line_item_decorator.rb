Spree::LineItem.class_eval do

  # custom hooks to allow price to be modified while maintaining tax.
  # different approach to to price_modifiers
  class_attribute :price_modifier_hooks
  self.price_modifier_hooks = Set.new

  def discounted_amount
    amount + promo_total + hook_totals
  end

  def hook_totals
    price_modifier_hooks.map { |hook|
      self.send(hook) if self.respond_to?(hook.to_sym)
    }.sum
  end

  def self.register_price_modifier_hook(hook)
    self.price_modifier_hooks.add(hook)
  end

end