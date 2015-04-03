Spree::Core::Engine.routes.draw do
  # Add your extension routes here

  namespace :api, defaults: {format: 'json'} do
    # delete 'orders/:order_id/line_items/:id/remove_add_ons', to: "line_items#remove_add_ons", as: :remove_add_ons
    resources :line_items do
      member do
        delete :remove_add_ons
      end
    end
  end

  namespace :admin do
    resources :add_ons
  end
end
