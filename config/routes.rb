Rails.application.routes.draw do
  devise_for :users, path: 'utilisateurs', path_names: {
    sign_in: 'connexion',
    sign_up: 'inscription'
}
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "articles#index"
  resources :articles, path: 'produits'


  resource :cart, only: [:show] do
    post 'add_article_to_cart', on: :collection
    delete 'remove_article_from_cart', on: :collection  # Suppression d'un article spécifique du panier
    delete 'clear_cart', on: :collection 
  end

scope '/checkout' do
  post 'create', to: 'checkout#create', as: 'checkout_create'
  get 'success', to: 'checkout#success', as: 'checkout_success'
  get 'cancel', to: 'checkout#cancel', as: 'checkout_cancel'
end

  get '/contact', to: 'static_pages#contact'

  resources :profiles, only: [:show]
end
