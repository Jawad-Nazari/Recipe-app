require 'rails_helper'

RSpec.describe 'Public Recipes Page', type: :system do
  describe 'Recipe /index' do
    before :each do
      @user = User.create!(name: 'name', email: 'email@gmail.com', password: 'password')
      @recipe = Recipe.create!(name: 'recipe', preparation_time: 1, cooking_time: 2, description: 'description',
                               public: true, user_id: @user.id)
      @user.skip_confirmation!
      @user.save!
      visit new_user_session_path
      fill_in 'user_email', with: 'email@gmail.com'
      fill_in 'user_password', with: 'password'
      click_button 'Log in'
      sleep(2)
      visit public_recipes_path
    end

    it 'displays the name of recipe' do
      expect(page).to have_content(@recipe.name)
    end

    it 'displays the name of the user' do
      expect(page).to have_content(@user.name)
    end

    it 'displays the recipe details and user' do
      expect(page).to have_content(@recipe.name)
      expect(page).to have_content("By: #{@user.name}")
      expect(page).to have_content("Total Food Items: #{recipe.recipe_foods.length}")
      total_price = @recipe.recipe_foods.sum { |food| food.food.price }
      expect(page).to have_content("Total Price: $ #{total_price}")
    end
  end
end
