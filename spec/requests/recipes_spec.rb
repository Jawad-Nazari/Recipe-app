require 'rails_helper'

RSpec.describe 'Recipes', type: :request do
  describe 'GET /index' do
    it 'returns http success when authenticated' do
      user = FactoryBot.create(:user)

      post user_session_path, params: { user: { email: user.email, password: 'password' } }

      get recipes_path

      expect(response).to have_http_status(:success)
    end
  end
end
