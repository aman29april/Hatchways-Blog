Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: redirect('api/ping')

  namespace :api do
    get '/posts', to: 'posts#index'
    get '/ping', to: 'application#ping'
  end
end
