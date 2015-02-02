module Spree
  OrderUpdater.class_eval do

    def persist_add_on_totals
      total = order.line_item_adjustments.add_ons.eligible.sum(:amount) || 0
      order.update_columns(
          add_on_toal: total,
          updated_at: Time.now
      )
    end

  end
end
