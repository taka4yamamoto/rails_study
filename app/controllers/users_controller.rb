class UsersController < ApplicationController
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
end
