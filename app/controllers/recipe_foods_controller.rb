class RecipeFoodsController < ApplicationController
  def new
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = @recipe.recipe_foods.build
    @foods = Food.all

    @food_recipe = @recipe.recipe_foods if params[:action] == 'edit' || params[:action] == 'update'
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = @recipe.recipe_foods.build(recipe_food_params)
    @recipe_food.price = params[:recipe_food][:price]

    if @recipe_food.save
      flash[:notice] = 'Ingredient added successfully!'
      redirect_to recipe_path(@recipe_food.recipe)
    else
      @foods = Food.all
      render :new
    end
  end

  def edit
    @recipe_food = RecipeFood.find(params[:id])
    @recipe = @recipe_food.recipe
    @foods = Food.all
  end

  def update
    @recipe_food = RecipeFood.find(params[:id])

    @recipe_food.price = params[:recipe_food][:price]

    if @recipe_food.update(recipe_food_params)
      flash[:notice] = 'Ingredient updated successfully!'
      redirect_to recipe_path(@recipe_food.recipe)
    else
      @foods = Food.all
      render :edit
    end
  end

  def destroy
    @recipe_food = RecipeFood.find(params[:id])
    @recipe = @recipe_food.recipe
    @recipe_food.destroy
    flash[:notice] = 'Ingredient deleted successfully!'
    redirect_to recipe_path(@recipe)
  end

  private

  def recipe_food_params
    params.require(:recipe_food).permit(:recipe_id, :food_id, :quantity)
  end
end
