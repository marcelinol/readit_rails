require 'rails_helper'

RSpec.describe MainController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'renders index' do
      get :index
      expect(response).to render_template(:index)
    end

    context 'associations' do
      let!(:article) { create(:article) }
      let(:recommendations_types) do
        Recommendation.subclasses.collect { |x| x.name.pluralize.parameterize }
      end

      before { get :index }

      it { expect(assigns(:recommendations)).not_to be_nil }
      it { expect(assigns(:recommendations)).to be_a Hash }
      it { expect(assigns(:recommendations).keys).to eq(recommendations_types) }
      it { expect(assigns(:recommendations)[:articles]).to be_a(ActiveRecord::Relation) }
      it { expect(assigns(:recommendations)[:articles].first).to be_a(Article) }
      it { expect(assigns(:recommendations)[:articles]).to eq(Article.all) }
    end
  end

end
