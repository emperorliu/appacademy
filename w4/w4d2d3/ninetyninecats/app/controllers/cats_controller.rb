class CatsController < ApplicationController

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
    @cat = Cat.new
    @colors = Cat::COLORS

    render :new
  end

  def edit
    @cat = Cat.find(params[:id])
    @colors = Cat::COLORS

    render :edit
  end

  def create
    @cat = Cat.new(cat_params)

    if @cat.save
      redirect_to cat_url(@cat)
    else
      render text: @cat.errors.full_messages
    end
  end

  private

    def cat_params
      params.require(:cat)
            .permit(:name, :birth_date, :color, :sex, :description)
    end
end
