Spree::Api::LineItemsController.class_eval do

  def destroy
    set_line_item
    variant = Spree::Variant.unscoped.find(@line_item.variant_id)
    @order.contents.remove(variant, @line_item.quantity, get_line_item_options)
    respond_with(@line_item, status: 204)
  end

  private

  def get_line_item_options
    options = {}
    line_item_options.each do |key|
      options[key] = @line_item[key] if @line_item.respond_to?(key.to_sym)
    end
    options
  end

end