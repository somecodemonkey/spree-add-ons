module Spree
  class AddOnAdjuster

    def initialize(add_on)
      @add_on = add_on
    end

    def adjust(item)
      puts "TODO ADJUST THE ITEM"
    end
    #
    # def self.apply_fee?(lineitem)
    #
    #   add_ons = lineitem.product.add_ons
    #   pre_existing = add_ons.select{|a| a.sku == self.sku}
    #
    #   return if pre_existing
    #   # we could clean this up by either forcing all products to have a fee defined or not allowing 0$ design fees
    #   # design.present? and design_fee.present? and design_fee.matches_type?(design.design_type) and Spree::ItemDesign::Config.use_fees
    # end
    #
    # def create_adjustment(order, item)
    #   amount = compute_amount(item)
    #   return unless amount
    #
    #   self.adjustments.create!({
    #                                adjustable: item,
    #                                amount: amount,
    #                                eligible: true,
    #                                order_id: item.order_id,
    #                                label: label,
    #                                included: false
    #                            })
    # end
    #
    # def compute_amount(item)
    #   price * item.quantity
    # end
    #
    # def name_with_amount
    #   "#{name} - #{Spree::Money.new(amount).to_s}"
    # end
    #
    # def matches_type?(type)
    #   design_type == type
    # end

  end
end