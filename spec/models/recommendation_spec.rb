require 'rails_helper'

describe Recommendation do
  context 'validations -' do
    context 'validates presence of address' do
      let(:recommendation) { build(:recommendation, address: nil) }

      it { expect(recommendation).not_to be_valid }
    end

    context 'validates presence of title' do
      let(:recommendation) { build(:recommendation, title: nil) }

      it { expect(recommendation).not_to be_valid }
    end
  end
end
