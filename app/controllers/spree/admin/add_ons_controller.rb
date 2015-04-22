module Spree
  module Admin
    class AddOnsController < Spree::Admin::ResourceController
      before_action :load_data, only: [:new, :edit, :create]

      def location_after_save
        edit_object_url(@add_on)
      end

      def show
        redirect_to edit_object_url(@add_on)
      end

      def load_data
        @calculators = Rails.application.config.spree.calculators.add_ons
        @images = @add_on.images || [Spree::Image.new]
      end
    end
  end
end