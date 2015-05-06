module Spree
  module Admin
    class AddOnsController < ResourceController
      before_action :load_data

      def location_after_save
        edit_object_url(@add_on)
      end

      def show
        redirect_to edit_object_url(@add_on)
      end

      private

      def load_data
        @calculators = Rails.application.config.spree.calculators.add_ons
      end
    end
  end
end