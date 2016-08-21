require 'rails_helper'

describe Recommendation do
  describe 'validations' do
    context 'validates presence of address' do
      let(:recommendation) { build(:recommendation, address: nil) }

      it { expect(recommendation).not_to be_valid }

      it 'contains address in errors' do
        recommendation.valid?

        expect(recommendation.errors.keys).to include(:address)
      end
    end

    context 'validates presence of title' do
      let(:recommendation) { build(:recommendation, title: nil) }

      it { expect(recommendation).not_to be_valid }

      it 'contains title in errors' do
        recommendation.valid?

        expect(recommendation.errors.keys).to include(:title)
      end
    end

    context 'when it is valid' do
      # should I test this, since I have never seen this spec broken?
      # my guess is: yes. Because if someone mess with the factory or the validations, it will break
      let(:recommendation) { build(:recommendation) }

      it { expect(recommendation).to be_valid }
    end
  end
end
