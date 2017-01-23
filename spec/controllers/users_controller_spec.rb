require 'rails_helper'

RSpec.describe UsersController do
  describe 'new' do
    it 'renders sign up page' do
      get :new

      expect(response).to render_template('users/new')
    end
  end

  describe 'create' do
    context 'with invalid params' do
      it 'should be a bad request' do
        post :create, params: { user: FactoryGirl.attributes_for(:user, password: 'a') }

        aggregate_failures do
          expect(response).to have_http_status(:bad_request)
          expect(response).to render_template(:new)
        end
      end

      it 'does not create a new user' do
        expect do
          post :create,
               params: { user: FactoryGirl.attributes_for(:user, password: 'a') }
        end.not_to change(User, :count)
      end
    end

    context 'with valid params' do
      it 'redirects to index' do
        post :create, params: { user: FactoryGirl.attributes_for(:user) }

        aggregate_failures do
          expect(response).to have_http_status(:found)
          expect(response).to redirect_to(index_path)
        end
      end

      it 'creates a new user' do
        expect do
          post :create,
               params: { user: FactoryGirl.attributes_for(:user) }
        end.to change(User, :count).by(1)
      end
    end
  end
end
