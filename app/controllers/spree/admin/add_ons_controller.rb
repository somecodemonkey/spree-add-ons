module Spree
  module Admin
    class AddOnsController < ResourceController
      before_action :load_data, :parse_options

      def location_after_save
        edit_object_url(@add_on)
      end

      def show
        redirect_to edit_object_url(@add_on)
      end

      private

      def parse_options
        if (params[:add_on] || {})[:option_type_ids].present?
          params[:add_on][:option_type_ids] = (params[:add_on][:option_type_ids] || "").split(',')
        end
      end

      def load_data
        @calculators = Rails.application.config.spree.calculators.add_ons
      end
    end
  end
end