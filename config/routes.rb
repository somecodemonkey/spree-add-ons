Spree::Core::Engine.routes.draw do

  namespace :api, defaults: {format: 'json'} do
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
