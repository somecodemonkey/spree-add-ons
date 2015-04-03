Spree::PermittedAttributes.class_eval do
  class_variable_set(:@@line_item_attributes, class_variable_get(:@@line_item_attributes).push({add_on_ids: []}))
end