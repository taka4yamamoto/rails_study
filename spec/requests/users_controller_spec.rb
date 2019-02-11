require 'rails_helper'

RSpec.describe UsersController, type: :request do
  describe '#index' do
    describe '改善できそうなテスト' do
      context 'with 1 user' do
        let!(:user) { create(:user) }
        before { get '/users' } # ユーザー作成後に呼ばないと期待通りのテストにならない
        it { expect(response.status).to eq 200 }
      end

      context 'with 2 users' do
        let!(:users) { create_list(:user, 2) }
        before { get '/users' } # ユーザー作成後に呼ばないと期待通りのテストにならない
        it { expect(response.status).to eq 200 }
      end

      context 'with 2 users' do
        let!(:users) { create_list(:user, 2) }
        before { get '/users' } # ユーザー作成後に呼ばないと期待通りのテストにならない
        it do
          expect(response.status).to eq 200
          response_json = JSON.parse(response.body)
          expect(response_json.length).to eq 2
        end
      end
    end

    describe '改善後のテスト' do
      subject { get '/users' }

      context 'with 1 user' do
        let!(:user) { create(:user) }
        it { is_expected.to eq 200 }
      end

      context 'with 2 users' do
        let!(:users) { create_list(:user, 2) }
        it { is_expected.to eq 200 }
      end

      context 'with 2 users' do
        let!(:users) { create_list(:user, 2) }
        it do
          is_expected.to eq 200
          response_json = JSON.parse(response.body)
          expect(response_json.length).to eq 2
        end
      end
    end
  end
end
