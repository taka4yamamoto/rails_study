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

    context 'user has invalid name' do
      let(:user) { build(:user, :email, name: 'a' * 51) }
      it { is_expected.to be false }
    end

    context 'user has invalid email' do
      let(:user) { build(:user, :name, email: 'a' * 244 + '@example.com') }
      it { is_expected.to be false }
    end
  end

  describe 'following' do
    subject { user.following }
    let(:user) { create(:user) }

    context 'follow no user' do
      it { is_expected.to be_empty }
      it { expect(subject.count).to eq 0 }
    end

    context 'follow 1 user' do
      let(:another_user) { create(:user) }
      let!(:user_follow) { create(:relationship, follower_id: user.id, followed_id: another_user.id) }
      it { is_expected.to eq [another_user] }
      it { expect(subject.count).to eq 1 }
    end
  end

  describe 'followers' do
    subject { user.followers }
    let(:user) { create(:user) }

    context 'no follower' do
      it { is_expected.to be_empty }
      it { expect(subject.count).to eq 0 }
    end

    context '1 follower' do
      let(:another_user) { create(:user) }
      let!(:another_user_follow) { create(:relationship, follower_id: another_user.id, followed_id: user.id) }
      it { is_expected.to eq [another_user] }
      it { expect(subject.count).to eq 1 }
    end
  end
end
