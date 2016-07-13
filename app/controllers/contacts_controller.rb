class ContactsController < ApplicationController
before_action :find_contact, only: [:show, :edit, :update, :destroy]
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new contact_params
    if @contact.save
      flash[:notice] = "you info have been saved"
      redirect_to contact_path(@contact)
    else
      flash[:alert] = "info not save"
      render :new
    end
  end

  def show
  end

  def index
    @contacts = Contact.order(created_at: desc:)
  end

  def edit
  end

  def update
    if @contact.update contact_params
      flash[:notice] = "the info have been updated"
      redirect_to contact_path(@contact)
    else
      flash[:alert] = "the contact could not be updated"
      render :edit
    end
  end

  def destroy
    @contact.destroy
    flash[:notice]= "info have been deleted"
    redirect_to contacts_path
  end



private

  def contact_params
  params.require(:contact).permit(:name, :subject, :email, :message)
  end

  def find_contact
    @contact = Contact.find params[:id]
  end

end
