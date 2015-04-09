Deface::Override.new(:virtual_path => "spree/admin/shared/_order_summary",
                     :name => "add_design_fee_to_order_summary",
                     :insert_before => "[data-hook='admin_order_tab_subtotal_title']",
                     :partial => "spree/admin/overrides/orders/design_fee_total")