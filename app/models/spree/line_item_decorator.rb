module Spree
  LineItem.class_eval do
    validate :ensure_valid_add_ons

    after_save :create_add_on_adjustments
    after_save :persist_add_on_total

    attr_accessor :add_on_ids

    def add_ons
      Spree::AddOn.joins(:adjustments).where("source_id = spree_add_ons.id")
    end

    def add_ons=(*new_add_ons)
      @add_on_ids = new_add_ons.flatten!.map { |add_on| add_on.id }
      save!
    end

    private

    def create_add_on_adjustments
      unless add_ons.empty?
        adjustments.add_ons.destroy_all
      end

      if @add_on_ids.present?
        add_ons_to_add = Spree::AddOn.find(@add_on_ids)
        add_ons_to_add.each { |add_on| add_on.adjust(self) }
        @add_on_ids = nil
      end

      ensure_valid_add_ons
    end

    def persist_add_on_total
      update_columns(:add_on_total => add_on_total)
    end

    def ensure_valid_add_ons
      invalid_add_ons = add_ons - product.add_ons
      unless add_ons.empty? || invalid_add_ons.empty?
        invalid_message = invalid_add_ons.map { |add| add.name }.join(", ") + (invalid_add_ons.length > 1 ? " are" : " is")
        errors[:base] << "#{invalid_message} not a valid add on for #{product.name}"
      end
    end
  end
end