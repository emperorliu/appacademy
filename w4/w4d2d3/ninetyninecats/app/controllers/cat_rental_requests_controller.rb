class CatRentalRequestsController < ApplicationController
  before_action :ensure_logged_in, only: [:approve, :deny]

  def index
    @cat = Cat.find(params[:cat_id])
    @requests = @cat.cat_rental_requests
    render :index
  end

  def new
    @cat_rental_request = CatRentalRequest.new
    @cat_id = params[:cat_id]
    render :new
  end

  def create
    @cat_rental_request = CatRentalRequest.new(cat_rental_request_params)
    if @cat_rental_request.save
      redirect_to cat_url(Cat.find(params[:cat_rental_request][:cat_id]))
    else
      render text: @cat_rental_request.errors.full_messages
    end
  end

  def show
    @cat_rental_request = CatRentalRequest.find(params[:id])
    @cat_name = Cat.find(@cat_rental_request.cat_id).name
  end

  def edit
    @cat_rental_request = CatRentalRequest.find(params[:id])
    @cat_name = Cat.find(@cat_rental_request.cat_id).name
    render :edit
  end

  def destroy
    @cat_rental_request = CatRentalRequest.find(params[:id])
    @cat_rental_request.destroy!
    redirect_to cat_url(Cat.find(@cat_rental_request.cat_id))
  end

  def approve
    @cat_rental_request = CatRentalRequest.find(params[:id])
    @cat_rental_request.approve!
    @cat_rental_request.transaction do
      @cat_rental_request.save!
    end

    redirect_to cat_url(Cat.find(@cat_rental_request.cat_id))
  end

  def deny
    @cat_rental_request = CatRentalRequest.find(params[:id])
    @cat_rental_request.deny!
    @cat_rental_request.save!

    redirect_to cat_url(Cat.find(@cat_rental_request.cat_id))
  end

  private

    def cat_rental_request_params
      params.require(:cat_rental_request).permit(:status, :start_date,
                                                 :end_date, :cat_id)
    end

    def ensure_logged_in
      unless current_user.id == Cat.find(CatRentalRequest
                                   .find(params[:id]).cat_id).user_id
        redirect_to cats_url
      end
    end

end
