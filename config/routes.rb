Rails.application.routes.draw do
   resources :recipes, only: [:index] do
  end
end
