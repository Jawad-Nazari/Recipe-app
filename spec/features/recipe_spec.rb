require 'rails_helper'

RSpec.describe 'Recipes Page', type: :system do
  describe 'Recipe /index' do
    before :each do
      @user = User.create!(name: 'name', email: 'email@gmail.com', password: 'password')
      @recipe = Recipe.create!(name: 'recipe', preparation_time: 1, cooking_time: 2, description: 'description',
                               public: true, user_id: @user.id)
      @user.save!
      visit new_user_session_path
      fill_in 'user_email', with: 'email@gmail.com'
      fill_in 'user_password', with: 'password'
      click_button 'Log in'
      sleep(2)
      visit recipes_path
    end

    it 'displays the name of recipe' do
      expect(page).to have_content(@recipe.name)
    end

    it 'displays the description of recipe' do
      expect(page).to have_content(@recipe.description)
    end

    it 'displays a button with text Add New Recipe' do
      expect(page).to have_content('Add New Recipe')
    end

    it ' has button to redirect to a page to add new recipe' do
      click_link 'Add New Recipe'
      expect(page).to have_current_path new_recipe_path
    end

    it 'deletes a recipe when Remove button is clicked' do
      expect(page).to have_button('Remove')
    end
  end
end
