Spree::LineItem.class_eval do

  after_save :update_add_on_adjustments
  after_save :persist_add_on_total

  ###############
  # TODO remove this once/if integrated
  #  For now integrate this into pw
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
  ###############

  # potential optimization here
  def add_on_total
    adjustments.add_ons.reload.map do |adjustment|
      adjustment.update!(self)
    end.compact.sum
  end

  def add_ons
    adjustments.add_ons.map(&:source)
  end

  def add_ons=(*new_add_ons)
    new_add_ons.flatten!.each { |add_on| add_on.adjust(self) }
  end

  private

  def update_add_on_adjustments
    puts "Checking whether to update adjustments #{quantity_changed?} - #{quantity}"
    if quantity_changed?
      add_ons.each { |add_on| add_on.adjust(self) }
    end
  end

  def persist_add_on_total
    if quantity_changed?
      total = add_on_total
      puts "Persisting add on totals #{total}"
      update_columns(
          # :adjustment_total => adjustment_total + add_on_total,
          :add_on_total => total
      )
    end
  end

end