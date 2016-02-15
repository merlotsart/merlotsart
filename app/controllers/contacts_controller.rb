class ContactsController < ApplicationController
  def create
    UserMailer.contact(params).deliver_now
    flash[:notice] = 'Message Successfully Sent'
    redirect_to pages_path(page: 'contact')
  end

  def partner
    UserMailer.partner(params).deliver_now
    flash[:notice] = 'Message Successfully Sent'
    redirect_to pages_path(page: 'partner')
  end
end
