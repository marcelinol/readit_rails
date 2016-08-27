require 'rails_helper'

describe Article do
  describe 'validations' do
    context 'when the url is invalid' do
      it { expect(Article.new(address: 'www.pudim.com.br', title: 'title')).not_to be_valid }
      it { expect(Article.new(address: 'pudim.com.br', title: 'title')).not_to be_valid }
      it { expect(Article.new(address: 'xunda', title: 'title')).not_to be_valid }

      it 'has a good message' do
        article = Article.new(address: 'xunda', title: 'title')
        article.valid?

        expect(article.errors.messages[:address]).to include('The address is invalid')
      end
    end
  end
end
