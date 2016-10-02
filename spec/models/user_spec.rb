require 'rails_helper'

RSpec.describe User do
  let(:user) { build(:user) }
  describe 'validations' do

    context 'valid' do
      it { expect(user).to be_valid }
    end

    context 'invalid' do
      context 'when validating name' do
        let(:user) { build(:user, name: name) }

        context 'without a name' do
          let(:name) { '' }

          it 'should not be valid' do
            aggregate_failures do
              expect(user).not_to be_valid
              expect(user.errors.keys).to include(:name)
              expect(user.errors.full_messages.first).to include("can't be blank")
            end
          end
        end

        context 'with a giant name' do
          let(:name) { 'x'*51 }

          it 'should not be valid' do
            aggregate_failures do
              expect(user).not_to be_valid
              expect(user.errors.keys).to include(:name)
              expect(user.errors.full_messages.first).to include('too long')
            end
          end
        end
      end

      context 'when validating email' do
        let(:email) { 'dev@example.org' }
        let(:user)  { build(:user, email: email) }

        context 'without a email' do
          let(:email) { '' }

          it 'should not be valid' do
            aggregate_failures do
              expect(user).not_to be_valid
              expect(user.errors.keys).to include(:email)
              expect(user.errors.full_messages.first).to include("can't be blank")
            end
          end
        end

        context 'with a repeated email' do
          let(:second_user) { build(:user, name: 'another name', email: email.upcase) }
          before { user.save! }

          it 'should not be valid' do
            aggregate_failures do
              expect(user).to be_valid
              expect(second_user).not_to be_valid
              expect(second_user.errors.keys).to include(:email)
              expect(second_user.errors.full_messages.first).to include('has already been taken')
            end
          end
        end

        context 'with a giant email' do
          let(:email) { 'x'*244 + '@example.org' }

          it 'should not be valid' do
            aggregate_failures do
              expect(user).not_to be_valid
              expect(user.errors.keys).to include(:email)
              expect(user.errors.full_messages.first).to include('too long')
            end
          end
        end

        context 'with a invalid email address' do
          let(:email) { 'xunda' }

          it 'should not be valid' do
            aggregate_failures do
              expect(user).not_to be_valid
              expect(user.errors.keys).to include(:email)
              expect(user.errors.full_messages.first).to include('is invalid')
            end
          end

          let(:email) { 'xunda@example' }

          it 'should not be valid' do
            aggregate_failures do
              expect(user).not_to be_valid
              expect(user.errors.keys).to include(:email)
              expect(user.errors.full_messages.first).to include('is invalid')
            end
          end
        end
      end

      context 'when validating password' do
        let(:user) { build(:user, password: password) }

        context 'with a tiny password' do
          let(:password) { 'x'*5 }

          it 'should not be valid' do
            aggregate_failures do
              expect(user).not_to be_valid
              expect(user.errors.keys).to include(:password)
              expect(user.errors.full_messages.first).to include('too short')
            end
          end
        end
      end
    end
  end

  describe 'callbacks' do
    describe 'before_save' do
      describe 'email downcase' do
        let(:email) { 'XunDA@examPLE.ORg' }
        let(:user) { create(:user, email: email) }

        it { expect(user.email).to eql(email.downcase) }
      end
    end
  end
end
