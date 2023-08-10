Rails.application.routes.draw do
  root to: 'recipes#index'
devise_for :users, controllers: {
registrations: 'users/registrations'
}

get '/public_recipes', to: 'recipes#public_recipes'
   resources :recipes, only: [:index, :show, :new, :create, :destroy]
end
