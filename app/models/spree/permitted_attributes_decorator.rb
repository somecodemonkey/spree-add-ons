Spree::PermittedAttributes.class_eval do
  # clean up this
  class_variable_set(:@@line_item_attributes, class_variable_get(:@@line_item_attributes).push({add_ons: [:master_id, {values: [:color]}, :type]}))
end