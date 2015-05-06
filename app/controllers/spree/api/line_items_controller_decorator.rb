module Spree
  module Api
    LineItemsController.class_eval do
      before_action :set_line_item, only: [:show]

      self.line_item_options << {add_ons: [:id, :master_id, :options]}

      private

      def set_line_item
        @line_item = find_line_item if @line_item.nil?
      end
    end
  end
end
