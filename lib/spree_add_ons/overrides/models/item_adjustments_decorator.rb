
module ItemAdjustmentsExtensions
  def update_adjustments
    super
    item_adjustment_hooks.map { |hook|
      self.send(hook) if self.respond_to?(hook.to_sym)
    }
  end
end

Spree::ItemAdjustments.class_eval do
  class_attribute :item_adjustment_hooks
  self.item_adjustment_hooks = Set.new


  def self.register_item_adjustment_hook(hook)
    self.item_adjustment_hooks.add(hook)
  end

  prepend ItemAdjustmentsExtensions
end