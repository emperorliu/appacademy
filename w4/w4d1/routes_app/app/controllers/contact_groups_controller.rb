class ContactGroupsController < ApplicationController
  def index
    render json: ContactGroup.all.where(user_id: params[:user_id])
  end
end
