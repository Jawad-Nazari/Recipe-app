class ShoppingListsController < ApplicationController
  before_action :find_user

  def index
    @total_foods = 0
    @total_price = BigDecimal('0')
    @recipe_foods = []

    general_food_set = @user.foods.pluck(:id).to_set

    @user.recipes.each do |recipe|
      recipe.recipe_foods.includes(:food).each do |recipe_food|
        # If the food is already in the general food list, skip it
        next if general_food_set.include?(recipe_food.food_id)

        @total_foods += 1
        quantity = recipe_food.quantity.to_d
        @total_price += recipe_food.food.price * quantity
        @recipe_foods << recipe_food
      end
    end
  end

  private

  def find_user
    @user = current_user
  end

  def show
    @recipe = Recipe.includes(:recipe_foods).find(params[:id])
    @recipe_foods = @recipe.recipe_foods
  end
end
