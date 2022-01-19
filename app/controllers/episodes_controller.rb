# frozen_string_literal: true

class EpisodesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tv_show, only: %i[index create show update destroy]

  def index
    @episodes = Episode.where(tv_show_id: @tv_show.id)
    respond_to do |format|
      format.json { render json: @episodes }
    end
  end

  def show
    @episode = Episode.where(id: params[:id], tv_show_id: @tv_show.id).first
    respond_to do |format|
      format.json { render json: @episode }
    end
  end

  def create
    @episode = Episode.new(episode_params)
    @episode.tv_show_id = @tv_show.id
    return unless @episode.save

    respond_to do |format|
      format.json { render json: @episode }
    end
  end

  def update
    @episode = Episode.where(id: params[:id], tv_show_id: @tv_show.id).first
    return unless @episode.update(episode_params)

    respond_to do |format|
      format.json { render json: @episode }
    end
  end

  def destroy
    @episode = Episode.where(id: params[:id], tv_show_id: @tv_show.id).first
    @episode.delete
    respond_to do |format|
      format.json { render json: @episode }
    end
  end

  private

  def set_tv_show
    @tv_show = TvShow.find(params[:tv_show_id])
  end

  def episode_params
    params.require(:episode).permit(:title, :watched)
  end
end
