Spree::Order.class_eval do

  validate :current_add_ons
  after_save :line_item_add_ons

  delegate :persist_add_on_totals, to: :updater

  def display_add_on_total
    Spree::Money.new(add_on_total, {currency: currency})
  end

  # Hook for Spree 2.4 line items options matcher
  # Notes: The only way to distinctly match will be to include ALL the line_items add_ons
  def add_on_matcher(line_item, options)
    if (options[:add_ons] || []).empty? && line_item.add_ons.empty?
      return true
    end

    line_item_add_ons = line_item.add_ons.map(&:master_id)
    add_ons = options[:add_ons] || []

    return line_item_add_ons.present? && add_ons.present? && (line_item_add_ons - add_ons.map{ |add| add[:master_id] if add.has_key?(:master_id)}).empty?
  end

  def line_item_add_ons
    # Force rollback because add_ons are not created until line_item is after_update(save)
    # because line_items will not have an order until then
    raise ActiveRecord::Rollback if line_items.any? { |li| li.add_ons.present? && li.invalid? }
  end

  def current_add_ons
    line_items.each do |li|
      errors[:base] << li.errors.full_messages if li.invalid?
    end
  end

end