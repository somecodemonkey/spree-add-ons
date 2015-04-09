module Spree
  LineItem.class_eval do
    validate :ensure_valid_add_ons

    after_save :create_add_ons
    after_save :persist_add_on_total

    attr_accessor :add_on_ids

    has_many :add_ons, through: :adjustments, source: :source, source_type: "Spree::AddOn"

    def add_ons
      # Come on rails get your shit together
      # https://github.com/rails/rails/issues/10643
      Spree::AddOn.with_deleted.joins(:adjustments).where("source_id = spree_add_ons.id AND adjustable_id = ?", id)
    end

    def add_ons=(*new_add_ons)
      adjustments.add_ons.destroy_all
      new_add_ons.flatten!.each do |add_on|
        add_on.adjust(self)
      end
    end

    def available_add_ons
      product.add_ons.active
    end

    def display_add_on_total
      Spree::Money.new(add_on_total, { currency: currency })
    end

    private

    def create_add_ons
      if @add_on_ids.present?
        add_ons = Spree::AddOn.find(@add_on_ids)
        ensure_valid_add_ons(add_ons)
        if errors.any?
          raise ActiveRecord::Rollback
        else
          self.add_ons = add_ons
        end
        @add_on_ids = nil
      end
    end

    def ensure_valid_add_ons(proposed = add_ons)
      invalid_add_ons = proposed - product.add_ons
      unless proposed.empty? || invalid_add_ons.empty?
        invalid_message = invalid_add_ons.map { |add| add.name }.join(", ") + (invalid_add_ons.length > 1 ? " are" : " is")
        errors[:base] << "#{invalid_message} not a valid add on for #{product.name}"
      end
    end

    def persist_add_on_total
      update_columns(:add_on_total => add_on_total)
    end

  end
end