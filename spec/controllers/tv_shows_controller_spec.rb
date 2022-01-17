# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TvShowsController, type: :controller do
  let(:user) { create :user }

  before do
    sign_in user
  end

  describe 'GET #index' do
    let!(:tv_show1) { create :tv_show, user: user }
    let!(:tv_show2) { create :tv_show, user: user }

    subject { get :index, format: :json }

    it_behaves_like 'responds successfully with an HTTP 200 status code'

    it 'return list of all tv shows' do
      expect(JSON.parse(subject.body).count).to eq 2
    end
  end

  describe 'GET #show' do
    let!(:tv_show) { create :tv_show, user: user }
    let!(:episode1) { create :episode, tv_show: tv_show }
    let!(:episode2) { create :episode, tv_show: tv_show }

    subject { get :show, params: { id: tv_show.id }, format: :json }

    it_behaves_like 'responds successfully with an HTTP 200 status code'

    it 'return episode' do
      expect(JSON.parse(subject.body)['id']).to eq tv_show.id
    end

    it 'include episodes data in response' do
      expect(JSON.parse(subject.body)).to have_key('episodes')
      expect(JSON.parse(subject.body)['episodes']).to be_an(Array)
      expect(subject.body).to match(/#{tv_show.id}/)
    end
  end

  describe 'POST #create' do
    let(:params) { { title: 'House' } }

    subject { post :create, params: { tv_show: params } }

    before do
      request.accept = 'application/json'
    end

    it_behaves_like 'responds successfully with an HTTP 200 status code'

    it 'respond with created tv show' do
      expect(subject.body).to include('House')
    end
  end

  describe 'PUT #update' do
    let(:tv_show) { create :tv_show, user: user, title: 'Foo' }
    let(:params) { { title: 'House' } }

    subject { put :update, params: { id: tv_show.id, tv_show: params } }

    before do
      request.accept = 'application/json'
    end

    it_behaves_like 'responds successfully with an HTTP 200 status code'

    it 'respond with updated tv show' do
      expect(subject.body).to include('House')
    end
  end

  describe 'DELETE #destroy' do
    let(:tv_show) { create :tv_show, user: user, title: 'House' }

    subject { delete :destroy, params: { id: tv_show.id } }

    before do
      request.accept = 'application/json'
    end

    it_behaves_like 'responds successfully with an HTTP 200 status code'

    it 'respond with deleted tv show' do
      expect(subject.body).to include('House')
    end
  end
end
