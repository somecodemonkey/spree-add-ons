Deface::Override.new(:virtual_path => "spree/admin/products/_form",
                     :name => "admin_product_form_add_on_fields",
                     :insert_bottom => "[data-hook='admin_product_form_fields']",
                     :partial => "spree/admin/overrides/products/add_on_fields")