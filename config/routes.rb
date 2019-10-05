Rails.application.routes.draw do
  resources :zones
  resources :records, except: [:index, :show]
  root 'zones#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
