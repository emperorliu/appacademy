class UsersController < ApplicationController

  def index
    render json: User.all
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user
    else
      render json: user.errors.full_messages
    end
  end

  def comments
    render json: User.find(params[:id]).comments
  end

  def fav_contacts
    render json: Contact.where(user_id: params[:id]).where(fav_contacts: true)
  end

  def show
    user = User.find(params[:id])

    render json: user
  end

  def update
    user = User.update(user_params)
    if user.save
      render json: user
    else
      render json: user.errors.full_messages
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy

    render json: {}
  end

  private

  def user_params
    params[:user].permit(:username)
  end
end
