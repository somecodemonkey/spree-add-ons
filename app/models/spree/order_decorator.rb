Spree::Order.class_eval do

  # def add_on_total
    # line_item_adjustments.add_ons.eligible.sum(:amount) || 0
  # end

  def display_add_on_total
    Spree::Money.new(add_on_total, {currency: currency})
  end

  # Hook for Spree 2.4 line items options matcher
  # Notes: The only way to distinctly match will be to include ALL the line_items add_ons
  def add_on_matcher(line_item, options)
    return line_item.add_ons.present? && options.present? && (line_item.add_ons.map(&:id) - options[:add_ons]).empty?
  end

end