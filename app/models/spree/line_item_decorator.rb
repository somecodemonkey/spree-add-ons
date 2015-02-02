Spree::LineItem.class_eval do

  after_save :update_add_on_adjustments

  ###############
  # TODO remove this once/if integrated
  #  For now integrate this into pw
  class_attribute :price_modifier_hooks
  self.price_modifier_hooks = Set.new

  def discounted_amount
    puts "wtf"
    amount + hook_totals
  end

  def hook_totals
    puts "WHAT WHAT"
    price_modifier_hooks.map { |hook|
      self.send(hook, self)
    }.sum
  end

  def self.register_price_modifier_hook(hook)
    self.price_modifier_hooks.add(hook)
  end
  ###############

  # TODO do something about these...
  def add_on_total(line_item = nil)
    puts attributes["add_on_total"].inspect
    attributes["add_on_total"]
  end

  def add_ons
    adjustments.add_ons.map(&:source)
  end

  def add_ons=(*new_add_ons)
    add_ons.concat(new_add_ons.flatten!).each { |add_on| add_on.adjust(self) }
  end

  def add_add_ons(*add_ons)
    add_ons.flatten!.each { |add_on| add_on.adjust(self) }
  end

  private

  def update_add_on_adjustments
    puts "Checking whether to update adjustments #{quantity_changed?} - #{quantity}"
    if quantity_changed?
      add_ons.each { |add_on| add_on.adjust(self) }
      persist_add_on_total
    end
  end

  def persist_add_on_total
    if quantity_changed?
      add_on_total = adjustments.add_ons.reload.map do |adjustment|
        adjustment.update!(self)
      end.compact.sum
      puts "Persisting add on totals #{add_on_total}"

      update_columns(
          :add_on_total => add_on_total#,
          # :adjustment_total => adjustment_total + add_on_total
      )
    end
  end

end