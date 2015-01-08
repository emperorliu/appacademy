class CatsController < ApplicationController
  before_action :ensure_logged_in, only: [:index]
  before_action :ensure_owndership, only: [:edit, :update]

  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.includes(:cat_rental_requests).find(params[:id])
    @cat_rental_requests = @cat.cat_rental_requests
    render :show
  end

  def new
    @user_id = current_user.id
    @cat = Cat.new
    @colors = Cat::COLORS
    render :new
  end

  def edit
    @user_id = current_user.id
    @cat = Cat.find(params[:id])
    @colors = Cat::COLORS
    render :edit
  end

  def update
    @user_id = current_user.id
    @cat = Cat.find(params[:id])
    if @cat.update(cat_params)
      redirect_to cat_url(@cat)
    else
      render text: @cat.errors.full_messages
    end
  end

  def create
    @user_id = current_user.id
    @cat = Cat.new(cat_params)
    @cat.user_id = @user_id

    if @cat.save
      redirect_to cat_url(@cat)
    else
      render text: @cat.errors.full_messages
    end
  end

  private

    def ensure_owndership
      @cat = Cat.find(params[:id])
      unless @cat.user_id == current_user.id
        render text: "Your not the master of this beast... yet"
      end
    end

    def ensure_logged_in
      redirect_to new_session_url unless current_user
    end

    def cat_params
      params.require(:cat)
            .permit(:name, :birth_date, :color, :sex, :description, :user_id)
    end
end
