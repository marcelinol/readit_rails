require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST create' do
    context 'failure cases' do
      context 'with inexistent user' do
        it 'responds with not found' do
          post :create, params: { session: { email: 'dev@example.org', password: 'xunda123' } }

          expect(response).to have_http_status(:not_found)
        end
      end

      context 'with wrong password' do
        let!(:user) { create(:user) }
        let(:wrong_password) { user.password + 'x' }

        it 'responds with unauthorized' do
          post :create, params: { session: { email: user.email, password: wrong_password } }

          expect(response).to have_http_status(:unauthorized)
        end
      end
    end

    context 'success cases' do
      let!(:user) { create(:user) }

      it 'responds with unauthorized' do
        post :create, params: { session: { email: user.email, password: user.password } }

        expect(response).to redirect_to(index_path)
      end
    end
  end
end
