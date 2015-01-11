class UsersController < ApplicationController

  def new
    @user = User.new
    render :new
  end

  def show
    if current_user.nil?
      redirect_to new_session_url
      return
    else
      @user = current_user

      render :show
    end
  end

  def create
    @user = User.new(user_params)

    if @user.save
      # log_in!(@user)
      redirect_to user_url
    else
      render :new
    end
  end

  private

    def user_params
      params.require(:user).permit(:user_name, :password)
    end
end