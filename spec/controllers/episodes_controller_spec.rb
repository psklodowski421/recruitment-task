# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EpisodesController, type: :controller do
  let!(:tv_show) { create :tv_show, user: user }
  let(:user) { create :user }

  before do
    sign_in user
  end

  describe 'GET #index' do
    let!(:episode1) { create :episode, tv_show: tv_show }
    let!(:episode2) { create :episode, tv_show: tv_show }

    subject { get :index, params: { tv_show_id: tv_show.id }, format: :json }

    it_behaves_like 'responds successfully with an HTTP 200 status code'

    it 'return count of episodes' do
      expect(JSON.parse(subject.body).count).to eq 2
    end
  end

  describe 'GET #show' do
    let(:episode) { create :episode, tv_show: tv_show }

    subject { get :show, params: { id: episode.id, tv_show_id: tv_show.id }, format: :json }

    it_behaves_like 'responds successfully with an HTTP 200 status code'

    it 'return episode' do
      expect(JSON.parse(subject.body)['id']).to eq episode.id
    end
  end

  describe 'POST #create' do
    let(:params) { { title: 'House' } }

    subject { post :create, params: { tv_show_id: tv_show.id, episode: params } }

    before do
      request.accept = 'application/json'
    end

    it_behaves_like 'responds successfully with an HTTP 200 status code'

    it 'respond with created tv show' do
      expect(JSON.parse(subject.body)['title']).to eq('House')
    end
  end

  describe 'PUT #update' do
    let(:episode) { create :episode, tv_show: tv_show, title: 'Foo' }
    let(:params) { { title: 'House' } }

    subject { put :update, params: { id: episode.id, tv_show_id: tv_show.id, episode: params } }

    before do
      request.accept = 'application/json'
    end

    it_behaves_like 'responds successfully with an HTTP 200 status code'

    it 'respond with updated tv show' do
      expect(JSON.parse(subject.body)['title']).to eq('House')
    end
  end

  describe 'DELETE #destroy' do
    let(:episode) { create :episode, tv_show: tv_show, title: 'House' }

    subject { delete :destroy, params: { id: episode.id, tv_show_id: tv_show.id } }

    before do
      request.accept = 'application/json'
    end

    it_behaves_like 'responds successfully with an HTTP 200 status code'

    it 'respond with deleted tv show' do
      expect(JSON.parse(subject.body)['title']).to eq('House')
    end
  end
end
