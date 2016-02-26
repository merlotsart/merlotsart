class LicenseeApplicationsController < ApplicationController

  def new
    @licensee_application = LicenseeApplication.new
  end

  def create
    @licensee_application = LicenseeApplication.create(secure_params)

    if @licensee_application.save
      redirect_to :thank_you
    else
      flash[:notice] = 'Sorry your request was not sent. Please make your corrections and resend.'
      render :new
    end
  end

  private

  def secure_params
    params.require(:licensee_application).permit(:first_name, :last_name, :email, :phone, :interested_locations, :comments)
  end
end
