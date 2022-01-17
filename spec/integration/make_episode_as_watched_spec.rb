# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '', type: :request do
  let(:user) { create :user, password: 'secret123' }
  let(:tv_show) { create :tv_show, user: user, title: 'SOA' }
  let(:ep1) { create :episode, episode: 1, tv_show: tv_show, watched: false }
  let(:ep2) { create :episode, episode: 2, tv_show: tv_show, watched: false }

  before do
    tv_show.episodes << [ep1, ep2]
  end

  pending 'Making API authentication is not task for 4h ^^'

  # it 'mark episode as watched' do
    # post '/users/sign_in', params: { user: { email: 'foo@example.com', password: 'secret123' } }
    #
    # put "/episodes/#{ep1.id}", params: { tv_show_id: tv_show.id, episode: { watched: true } },
    #                            headers: { 'ACCEPT' => 'application/json' }
    # get '/episodes', params: { tv_show_id: tv_show.id }, headers: { 'ACCEPT' => 'application/json' }
    #
    # expect(response.body).to include('true')
  # end
end
