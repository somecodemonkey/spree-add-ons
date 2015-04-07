module SpreeAddOns
  module Generators
    class InstallGenerator < Rails::Generators::Base

      class_option :auto_run_migrations, :type => :boolean, :default => false

      def add_javascripts
        append_file 'vendor/assets/javascripts/spree/frontend/all.js', "//= require spree/frontend/spree_add_ons\n"
        append_file 'vendor/assets/javascripts/spree/backend/all.js', "//= require spree/backend/spree_add_ons\n"
      end

      def add_stylesheets
        inject_into_file 'vendor/assets/stylesheets/spree/frontend/all.css', " *= require spree/frontend/spree_add_ons\n", :before => /\*\//, :verbose => true
        inject_into_file 'vendor/assets/stylesheets/spree/backend/all.css', " *= require spree/backend/spree_add_ons\n", :before => /\*\//, :verbose => true
      end

      def add_migrations
        run 'bundle exec rake railties:install:migrations FROM=spree_add_ons'
      end

      def run_migrations
        run_migrations = options[:auto_run_migrations] || ['', 'y', 'Y'].include?(ask 'Would you like to run the migrations now? [Y/n]')
        if run_migrations
          run 'bundle exec rake db:migrate'
        else
          puts 'Skipping rake db:migrate, don\'t forget to run it!'
        end
      end

      def configure_application
        application <<-APP
          config.to_prepare do
            Dir.glob("#{File.join(File.dirname(__FILE__), 'templates/**/*.rb')}") do |c|
              Rails.configuration.cache_classes ? require(c) : load(c)
            end
          end
        APP
      end

    end
  end
end
