module Spree
  module Api
    LineItemsController.class_eval do

      self.line_item_options << {add_on_ids: []}

      def remove_add_ons
        @line_item = find_line_item
        add_on_ids = @line_item.add_ons.map { |add| add.id }
        if params[:line_item].present? && (add_on_params = (line_item_params[:options] || {})[:add_on_ids]).present?
          @line_item.add_on_ids = add_on_ids - add_on_params
        else
          @line_item.add_on_ids = []
        end
        @line_item.save!
        respond_with(@line_item, default_template: :show)
      end
    end
  end
end
