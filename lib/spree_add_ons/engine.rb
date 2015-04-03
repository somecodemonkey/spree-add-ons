module SpreeAddOns
  class Engine < Rails::Engine
    require 'spree/core'
    isolate_namespace Spree
    engine_name 'spree_add_ons'

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), '../../app/**/*_decorator*.rb')) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end

      if Rails.env.test?
        Dir.glob(File.join(File.dirname(__FILE__), './overrides/**/*_decorator*.rb')) do |c|
          Rails.configuration.cache_classes ? require(c) : load(c)
        end

        if Spree::LineItem.table_exists?
          Spree::LineItem.register_price_modifier_hook(:add_on_total)
        end

        if Spree::Adjustment.table_exists?
          Spree::ItemAdjustments.register_item_adjustment_hook(:update_add_on_adjustments)
        end
      end

      if Spree::Order.table_exists?
        Spree::Order.register_line_item_comparison_hook(:add_on_matcher)
      end

      # Eager load classes into memory so we can know which subclasses exist
      unless Rails.env.production?
        ActionDispatch::Reloader.to_prepare do
          Rails.application.eager_load!
        end
      end
    end

    config.to_prepare &method(:activate).to_proc
  end
end
