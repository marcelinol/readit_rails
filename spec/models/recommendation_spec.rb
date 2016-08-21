require 'rails_helper'

RSpec.describe Recommendation, type: :model do
  context 'validations' do
    it 'validates presence of address' do
      recommendation = build(:recommendation, address: nil)

      expect(recommendation).not_to be_valid
    end
  end
end
