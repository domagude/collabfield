class ContactsController < ApplicationController

  def create
    @contact = current_user.contacts.create(contact_id: params[:contact_id])
    respond_ok
  end

  def update
    @contact = Contact.find_by_users(params[:id], current_user.id)
    @contact.update(accepted: true)
    respond_ok
  end

  def destroy
    @contact = Contact.find_by_users(params[:id], current_user.id)
    @contact.destroy
    respond_ok
  end

  private

  def respond_ok
    respond_to do |format|
      format.json  { head :ok } 
    end
  end

end
