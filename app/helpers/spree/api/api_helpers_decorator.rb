Spree::Api::ApiHelpers.module_eval do
  class_variable_set(:@@line_item_attributes, class_variable_get(:@@line_item_attributes).push(:add_ons))
  class_variable_set(:@@product_attributes, class_variable_get(:@@product_attributes).push(:add_ons))
end