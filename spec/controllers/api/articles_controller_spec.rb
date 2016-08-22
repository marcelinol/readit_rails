require 'rails_helper'

describe Api::ArticlesController do
  describe 'POST #create' do
    context 'without a token' do
      it 'returns http success' do
        post :create, params: { article: FactoryGirl.attributes_for(:article) }

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
