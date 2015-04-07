Spree::Admin::ProductsController.class_eval do

  before_action :parse_add_ons

  private

  def parse_add_ons
    if (params[:product] || {})[:add_on_ids].present?
      params[:product][:add_on_ids] = params[:product][:add_on_ids].split(",")
    end
  end
end