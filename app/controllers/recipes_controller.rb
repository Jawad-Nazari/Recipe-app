class RecipesController < ApplicationController
  load_and_authorize_resource
  before_action :set_recipe, only: %i[show edit update destroy]

  def index
    @recipes = current_user.recipes
  end

  def show
    @user = current_user
    @recipe = Recipe.find(params[:id])
    @food_recipe = RecipeFood.where(recipe_id: @recipe.id).includes([:food])
  end

  def new
    @recipe = Recipe.new
  end

  def edit; end

  def toggle_public
    @recipe = Recipe.find(params[:id])
    @recipe.toggle!(:public)
    redirect_to @recipe
  end

  def public_recipes
    @public = Recipe.includes(:user, recipe_foods: :food).all
  end

  def create
    @recipe = current_user.recipes.new(recipe_params)
    respond_to do |format|
      if @recipe.save
        format.html { redirect_to @recipe, notice: 'Great job!' }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new, notice: 'Whoops!' }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to @recipe, notice: 'Great job!' }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit, notice: 'Whoops!' }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @recipe.destroy
    respond_to do |format|
      format.html { redirect_to recipes_url, notice: 'Bravo!' }
      format.json { head :no_content }
    end
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :description, :public, :cooking_time)
  end
end
