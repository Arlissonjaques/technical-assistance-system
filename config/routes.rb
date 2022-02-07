Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    mount_devise_token_auth_for 'User', at: 'auth'
    namespace :v1 do
      resources :addresses, only: [:show, :create, :update]
      resources :clients
      resources :devices
    end
  end
end
