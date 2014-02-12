class PagesController < ApplicationController
  def index
  end

  def send_contact
    contact_params = params[:contact]

    if contact_params[:email].blank? ||
       contact_params[:name].blank? ||
       contact_params[:product_interest].blank? ||
       contact_params[:message].blank? ||
       !verify_recaptcha

      flash[:danger] = "Please fill up all the fields."
      redirect_to page_path("contact")
    else
      BaseMailer.contact_email(contact_params).deliver
      flash[:notice] = "Some message here."
      redirect_to root_path
    end
  end
end
