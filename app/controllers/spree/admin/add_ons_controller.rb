module Spree
  module Admin
    class AddOnsController < Spree::Admin::ResourceController
      before_action :load_data, only: [:edit]

      def location_after_save
        edit_object_url(@add_on)
      end

      def show
        redirect_to edit_object_url(@add_on)
      end

      def load_data
        @calculators = Rails.application.config.spree.calculators.add_ons
        @image = @add_on.image || Spree::Image.new
      end
    end
  end
end