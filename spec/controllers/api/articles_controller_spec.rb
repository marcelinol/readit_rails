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
        @request.env['HTTP_AUTHORIZATION'] = 'Token token=invalid'
        post :create, params: { article: FactoryGirl.attributes_for(:article) }

        expect(response).to have_http_status(:unauthorized)
      end

      it 'does not create any article' do
        expect{
          @request.env['HTTP_AUTHORIZATION'] = 'Token token=invalid'
          post :create, params: { article: FactoryGirl.attributes_for(:article) }
        }.not_to change(Article, :count)
      end
    end

    context 'with a valid token' do
      it 'returns http success' do
        VCR.use_cassette('pudim') do
          @request.env['HTTP_AUTHORIZATION'] = 'Token token=xunda'
          post :create, params: { article: FactoryGirl.attributes_for(:article) }
        end

        expect(response).to have_http_status(:success)
      end

      context 'with authorization mocked' do
        before do
          allow(controller).to receive(:authenticate).and_return(true)
        end

        context 'with invalid params' do
          context 'without title' do
            let(:params) do
              { article: FactoryGirl.attributes_for(:article).except(:title), token: 'xunda' }
            end
            let(:expected_message) { "Title can't be blank" }

            before do
              VCR.use_cassette('pudim') { post :create, params: params }
            end

            it 'should be a bad request' do
              aggregate_failures do
                expect(response).to have_http_status(:bad_request)
                expect(response.body).to include(expected_message)
              end
            end
          end

          context 'without address' do
            let(:params) do
              { article: FactoryGirl.attributes_for(:article).except(:address), token: 'xunda' }
            end
            let(:expected_message) { "Address can't be blank" }

            before { post :create, params: params }

            it 'should be a bad request' do
              aggregate_failures do
                expect(response).to have_http_status(:bad_request)
                expect(response.body).to include(expected_message)
              end
            end
          end

          context 'without title and without address' do
            let(:params) do
              { article: FactoryGirl.attributes_for(:article).except(:title).except(:address), token: 'xunda' }
            end
            let(:expected_message) { "Address can't be blank, Address has invalid format, Title can't be blank" }

            before { post :create, params: params }

            it 'should be a bad request' do
              aggregate_failures do
                expect(response).to have_http_status(:bad_request)
                expect(response.body).to include(expected_message)
              end
            end
          end
        end

        context 'with valid params' do
          let(:params) do
            { article: FactoryGirl.attributes_for(:article), token: 'xunda' }
          end

          it 'returns success' do
            VCR.use_cassette('pudim') { post :create, params: params }

            expect(response).to have_http_status(:success)
          end

          context 'url with metatags' do
            let(:medium_address) { 'https://medium.com/startup-grind/12-years-a-hustler-time-to-go-home-35213b585eec#.9o5f6usml' }
            let(:params) do
              {
                token: 'xunda',
                article:
                { address: medium_address }
              }
            end

            it 'get info from metatags' do
              VCR.use_cassette('medium') { post :create, params: params }

              aggregate_failures do
                medium_article = Article.last
                expect(medium_article.description).to include("it’s been roller coaster")
                expect(medium_article.title).to eq("12 Years a Hustler, Time to Go Home – Startup Grind")
                expect(medium_article.image).to eq("https://cdn-images-1.medium.com/max/1200/1*32t_pvYBSdQ71r21dH33cQ.jpeg")
              end
            end
          end

          it 'create a new article' do
            VCR.use_cassette('pudim') do
              expect { post :create, params: params }.to change{ Article.count }.from(0).to(1)
            end
          end
        end
      end
    end
  end
end
