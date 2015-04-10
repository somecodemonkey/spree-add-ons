module Spree
  module Admin
    class AddOnsController < Spree::Admin::ResourceController
      def location_after_save
        edit_object_url(@add_on)
      end
    end
  end
end