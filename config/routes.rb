Rails.application.routes.draw do
   root to: 'recipes#index'
 devise_for :users, controllers: {
  registrations: 'users/registrations'
}
   resources :recipes, only: [:index] do
  end
end