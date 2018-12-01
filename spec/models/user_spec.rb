require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validity' do
    subject { user.valid? }

    context 'user has no name and email' do
      let(:user) { build(:user, name: '', email: '') }
      it { is_expected.to be false }
    end

    context 'user has no name' do
      let(:user) { build(:user, email: '') }
      it { is_expected.to be false }
    end

    context 'user has no email' do
      let(:user) { build(:user, name: '') }
      it { is_expected.to be false }
    end

    context 'user has name and email' do
      let(:user) { build(:user, name: 'Name', email: 'email@example.com') }
      it { is_expected.to be true }
    end
  end
end
