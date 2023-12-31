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
      visit public_recipes_path
    end

    it 'displays the name of recipe' do
      expect(page).to have_content(@recipe.name)
    end

    it 'displays the name of the user' do
      expect(page).to have_content(@user.name)
    end

    it 'should display the title of the page as Public Recipes' do
      expect(page).to have_content('Public Recipes')
    end

    it 'displays the Total Food Items' do
      expect(page).to have_content('Total Food Items: 0')
    end

    it 'displays the Total Price' do
      expect(page).to have_content('Total Price: $ 0')
    end
  end
end
