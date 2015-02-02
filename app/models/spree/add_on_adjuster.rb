module Spree
  class AddOnAdjuster
    attr_reader :add_on
    delegate :price, :name, to: :add_on

    def initialize(add_on)
      add_on.reload if add_on.persisted?
      @add_on = add_on
    end

    def adjust(item)
      add_on.adjustments.destroy_all

      amount = compute_amount(item)
      puts "Adjuster be adjusting #{amount > 0 && is_new?(item)}"

      add_on.adjustments.create!({
                                     adjustable: item,
                                     amount: amount,
                                     eligible: true,
                                     order_id: item.order_id,
                                     label: name_with_amount(amount),
                                     included: false
                                 }) if amount > 0 && is_new?(item)
    end

    def compute_amount(item)
      price * item.quantity
    end

    def name_with_amount(amount = price)
      "#{name} - #{Spree::Money.new(amount).to_s}"
    end

    private

    def is_new?(item)
      add_on.adjustments.where(adjustable_id: item.id).empty?
    end
  end
end