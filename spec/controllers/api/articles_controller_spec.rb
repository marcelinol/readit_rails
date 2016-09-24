require 'rails_helper'

describe Api::ArticlesController do
  describe 'POST #create' do
    context 'without a token' do
      it 'returns http unauthorized' do
        post :create, params: { article: FactoryGirl.attributes_for(:article) }

        expect(response).to have_http_status(:unauthorized)
      end

      it 'does not create any article' do
        expect{
          post :create, params: { article: FactoryGirl.attributes_for(:article) }
        }.not_to change(Article, :count)
      end
    end

    context 'with an invalid token' do
      it 'returns http unauthorized' do
        @request.env["HTTP_AUTHORIZATION"] = "Token token=invalid"
        post :create, params: { article: FactoryGirl.attributes_for(:article) }

        expect(response).to have_http_status(:unauthorized)
      end

      it 'does not create any article' do
        expect{
          @request.env["HTTP_AUTHORIZATION"] = "Token token=invalid"
          post :create, params: { article: FactoryGirl.attributes_for(:article) }
        }.not_to change(Article, :count)
      end
    end

    context 'with a valid token' do
      it 'returns http success' do
        @request.env["HTTP_AUTHORIZATION"] = "Token token=xunda"
        post :create, params: { article: FactoryGirl.attributes_for(:article) }

        expect(response).to have_http_status(:success)
      end

      context 'with authorization mocked' do
        before do
          controller.stub(:authenticate).and_return(true)
        end

        context 'with invalid params' do
          context 'without title' do
            let(:params) do
              { article: FactoryGirl.attributes_for(:article).except(:title), token: 'xunda' }
            end
            let(:expected_message) { "title can't be blank" }

            before { post :create, params: params }

            it { expect(response).to have_http_status(:bad_request) }
            it { expect(response.body).to include(expected_message) }
          end

          context 'without address' do
            let(:params) do
              { article: FactoryGirl.attributes_for(:article).except(:address), token: 'xunda' }
            end
            let(:expected_message) { "address can't be blank" }

            before { post :create, params: params }

            it { expect(response).to have_http_status(:bad_request) }
            it { expect(response.body).to include(expected_message) }
          end
        end

        context 'with valid params' do
          let(:params) do
            { article: FactoryGirl.attributes_for(:article), token: 'xunda' }
          end

          it 'returns success' do
            post :create, params: params

            expect(response).to have_http_status(:success)
          end

          it 'create a new article' do
            expect{ post :create, params: params }.to change{ Article.count }.from(0).to(1)
          end
        end
      end
    end
  end
end
