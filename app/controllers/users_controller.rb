class UsersController < ApplicationController
  before_action :set_user, only: [:following, :followers]

  def index
    render json: User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
  end

  def create
    @user = User.create(name: params[:name], email: params[:email])
    render json: @user
  end

  def following
    render json: @user.following
  end

  def followers
    render json: @user.followers
  end

  private

    def set_user
      @user = User.find(params[:id])
    end
end
