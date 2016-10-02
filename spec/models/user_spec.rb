require 'rails_helper'

RSpec.describe User do
  let(:user) { build(:user) }
  describe 'validations' do

    context 'valid' do
      it { expect(user).to be_valid }
    end

    context 'invalid' do
      context 'without a name' do
        let(:user) { build(:user, name: '') }

        it { expect(user).not_to be_valid }
      end

      context 'without a email' do
        let(:user) { build(:user, email: '') }

        it { expect(user).not_to be_valid }
      end

      context 'with a repeated email' do
        let(:second_user) { build(:user, name: 'another name') }
        before { user.save! }

        it { expect(second_user).not_to be_valid }
      end

    end
  end
end
