class RecipesController < ApplicationController
  before_action :authenticate_user!

  def index
    @user_recipes = current_user.recipes
  end

  def show
    @recipe = Recipe.find(params[:id])
  end
end
