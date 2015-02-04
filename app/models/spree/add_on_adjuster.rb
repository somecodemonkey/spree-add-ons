module Spree
  class AddOnAdjuster
    attr_reader :add_on
    delegate :price, :name, :active, to: :add_on

    def initialize(add_on)
      @add_on = add_on
      add_on.reload if add_on.persisted?
    end

    def adjust(item)
      adjustment = adjustment_for(item)
      adjustment.destroy if adjustment.present?

      create_adjustment(item) if can_do?(item)
    end

    def create_adjustment(item)
      amount = compute_amount(item)
      add_on.adjustments.create!({
                                     adjustable: item,
                                     amount: amount,
                                     eligible: true,
                                     order_id: item.order_id,
                                     label: name_with_amount(amount),
                                     included: false
                                 })
    end

    def compute_amount(item)
      price * item.quantity
    end

    def name_with_amount(amount = price)
      "#{name} - #{Spree::Money.new(amount).to_s}"
    end

    private

    def adjustment_for(item)
      add_on.adjustments.where(adjustable_id: item.id).first
    end

    def can_do?(item)
      active && compute_amount(item) > 0
    end
  end
end