class CatRentalRequestsController < ApplicationController

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
    @cat_rental_request = CatRentalRequest.new(cat_rr_params)
    if @cat_rental_request.save

      redirect_to cat_rental_request_url(@cat_rental_request.id)
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

   redirect_to cat_rental_request_url(@cat_rental_request)
  end

  def deny
    @cat_rental_request = CatRentalRequest.find(params[:id])
    @cat_rental_request.deny!
    @cat_rental_request.save!

    redirect_to cat_rental_request_url(@cat_rental_request)
  end

  private

    def cat_rr_params
      params.require(:cat_rental_request)
            .permit(:status, :start_date, :end_date, :cat_id)
    end

end
