class ContactsController < ApplicationController

  def index
    render json: User.find(params[:user_id]).contacts + \
                 User.find(params[:user_id]).shared_contacts
  end

  def show
    render json: Contact.find(params[:id])
  end

  def create
    contact = Contact.new(contact_params)
    if contact.save
      render json: contact
    else
      render json: contact.errors.full_messages
    end
  end

  def update
    contact = Contact.update(contact_params)
    if contact.save
      render json: contact
    else
      render json: contact.errors.full_messages
    end
  end

  def destroy
    contact = Contact.find(params[:id])
    contact.destroy

    render json: {}
  end

  def comments
    render json: Contact.find(params[:id]).comments
  end


  private

  def contact_params
    params.require(:contact).permit(:name, :email, :user_id)
  end


end
