Spree::Order.class_eval do

  after_save :line_item_add_ons

  def display_add_on_total
    Spree::Money.new(add_on_total, {currency: currency})
  end

  # Hook for Spree 2.4 line items options matcher
  # Notes: The only way to distinctly match will be to include ALL the line_items add_ons
  def add_on_matcher(line_item, options)
    return line_item.add_ons.present? && options.present? && (line_item.add_ons.map(&:id) - options[:add_ons]).empty?
  end

  def line_item_add_ons
    if line_items.any? { |li| li.add_ons.present? && li.invalid? }
      # Force rollback because add_ons are not created until line_item is after_update(save)
      # because line_items will not have an order until then
      raise ActiveRecord::Rollback
    end
  end
end