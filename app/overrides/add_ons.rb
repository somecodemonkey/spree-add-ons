Deface::Override.new(:virtual_path => "spree/admin/shared/_configuration_menu",
                     :name => "add_ons_settings_link",
                     :insert_bottom => "[data-hook='admin_configurations_sidebar_menu'], #admin_configurations_sidebar_menu[data-hook]",
                     :text => "<%= configurations_sidebar_menu_item 'Add Ons', admin_add_ons_path %>")
