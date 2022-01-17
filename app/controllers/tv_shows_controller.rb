# frozen_string_literal: true

class TvShowsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tv_show, only: %i[show update destroy]

  def index
    @tv_shows = TvShow.all
    respond_to do |format|
      format.json { render json: @tv_shows }
    end
  end

  def show
    respond_to do |format|
      format.json { render json: @tv_show }
    end
  end

  def create
    @tv_show = TvShow.new(tv_show_params)
    @tv_show.user_id = current_user.id
    return unless @tv_show.save

    respond_to do |format|
      format.json { render json: @tv_show }
    end
  end

  def update
    return unless @tv_show.update(tv_show_params)

    respond_to do |format|
      format.json { render json: @tv_show }
    end
  end

  def destroy
    @tv_show.delete
    respond_to do |format|
      format.json { render json: @tv_show }
    end
  end

  private

  def set_tv_show
    @tv_show = TvShow.find(params[:id])
  end

  def tv_show_params
    params.require(:tv_show).permit(:title)
  end
end
