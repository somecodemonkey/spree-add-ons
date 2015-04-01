Spree::ItemAdjustments.class_eval do

  # either this or calc sum on every call to add_on_total
  def update_add_on_adjustments
    add_on_total = adjustments.add_ons.reload.map do |adjustment|
      adjustment.update!(item)
    end.compact.sum

    item.update_columns(
        :add_on_total => add_on_total,
        :adjustment_total => item.adjustment_total + add_on_total,
    )
  end

end