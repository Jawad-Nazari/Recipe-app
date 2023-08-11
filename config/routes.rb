Rails.application.routes.draw do
  root to: 'recipes#index'
  devise_for :users, controllers: {
  registrations: 'users/registrations'
  }

  get '/public_recipes', to: 'recipes#public_recipes'
    resources :recipes, only: [:index, :show, :new, :create, :destroy]

  resources :recipes do
    member do
      patch 'toggle_public'
    end
    resources :foods, only: [:new, :create]
  end
end

# app/controllers/recipes_controller.rb
class RecipesController < ApplicationController
  # ...

  def show
    @recipe = Recipe.find(params[:id])
  end

  def toggle_public
    @recipe = Recipe.find(params[:id])
    @recipe.update(public: !@recipe.public)
    redirect_to recipe_path(@recipe)
  end
end

# app/controllers/foods_controller.rb
class FoodsController < ApplicationController
  before_action :set_recipe

  def new
    @food = Food.new
  end

  def create
    @food = @recipe.foods.build(food_params)
    if @food.save
      redirect_to recipe_path(@recipe), notice: "Food added successfully."
    else
      render :new
    end
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end

  def food_params
    params.require(:food).permit(:name, :quantity, :unit)
  end
end
