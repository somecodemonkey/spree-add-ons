module Spree
  module Api
    LineItemsController.class_eval do
      before_action :set_line_item, only: [:show]

      # Spree::AddOn.permitted_values.to_a
      # todo find away so controller doesnt know specific values
      self.line_item_options << {add_ons: [:id, :master_id, values: [:color]]}

      private

      def set_line_item
        @line_item = find_line_item if @line_item.nil?
      end
    end
  end
end
