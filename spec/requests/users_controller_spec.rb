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

  describe 'POST /users' do
    describe '改善できそうなテスト' do
      context 'with correct parameters' do
        let(:params) { { name: 'name', email: 'hoge@hoge' } }

        it 'should create 1 user' do
          expect(User.count).to eq 0
          post '/users', params: params
          expect(User.count).to eq 1
        end
      end

      context 'with empty parameters' do
        let(:params) { {} }

        it 'should not create any user' do
          expect(User.count).to eq 0
          post '/users', params: params
          expect(User.count).to eq 0
        end
      end
    end

    describe '改善後のテスト' do
      describe 'pattern 1' do
        context 'with correct parameters' do
          let(:params) { { name: 'name', email: 'hoge@hoge' } }

          it 'should create 1 user' do
            expect { post '/users', params: params }.to change(User, :count).from(0).to(1)
          end
        end

        context 'with empty parameters' do
          let(:params) { {} }

          it 'should not create any user' do
            expect { post '/users', params: params }.not_to change(User, :count).from(0)
          end
        end
      end

      describe 'pattern 2' do
        subject { -> { post '/users', params: params } }

        context 'with correct parameters' do
          let(:params) { { name: 'name', email: 'hoge@hoge' } }
          it { is_expected.to change(User, :count).from(0).to(1) }
        end

        context 'with empty parameters' do
          let(:params) { {} }
          it { is_expected.not_to change(User, :count).from(0) }
        end
      end
    end
  end

  describe 'GET /users/:id/following' do
    subject { get path }
    let(:path) { "/users/#{user.id}/following" }
    let(:user) { create(:user) }

    context 'follow no user' do
      it do
        is_expected.to eq 200
        response_json = JSON.parse(response.body)
        expect(response_json.length).to eq 0
      end
    end

    context 'follow 1 user' do
      let(:another_user) { create(:user) }
      let!(:user_follow) { create(:relationship, follower_id: user.id, followed_id: another_user.id) }

      it do
        is_expected.to eq 200
        response_json = JSON.parse(response.body)
        expect(response_json.length).to eq 1
      end
    end

    context 'follow 2 users' do
      let!(:other_users) {
        create_list(:user, 2).each do |another_user|
          create(:relationship, follower_id: user.id, followed_id: another_user.id)
        end
      }

      it do
        is_expected.to eq 200
        response_json = JSON.parse(response.body)
        expect(response_json.length).to eq 2
      end
    end
  end

  describe 'GET /users/:id/followers' do
    subject { get path }
    let(:path) { "/users/#{user.id}/followers" }
    let(:user) { create(:user) }

    context 'no follower' do
      it do
        is_expected.to eq 200
        response_json = JSON.parse(response.body)
        expect(response_json.length).to eq 0
      end
    end

    context '1 follower' do
      let(:another_user) { create(:user) }
      let!(:another_user_follow) { create(:relationship, follower_id: another_user.id, followed_id: user.id) }

      it do
        is_expected.to eq 200
        response_json = JSON.parse(response.body)
        expect(response_json.length).to eq 1
      end
    end

    context '2 followers' do
      let!(:other_users) {
        create_list(:user, 2).each do |another_user|
          create(:relationship, follower_id: another_user.id, followed_id: user.id)
        end
      }

      it do
        is_expected.to eq 200
        response_json = JSON.parse(response.body)
        expect(response_json.length).to eq 2
      end
    end
  end
end
