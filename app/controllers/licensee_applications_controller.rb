class LicenseeApplicationsController < ApplicationController

  def new
    @licensee_application = LicenseeApplication.new
  end

  def create
    @licensee_application = LicenseeApplication.new(secure_params)

    if @licensee_application.save
      UserMailer.licensee_application(@licensee_application).deliver_now
      redirect_to :thank_you
    else
      flash[:notice] = 'Sorry your request was not sent. Please make your corrections and resend.'
      render :new
    end
  end

  def thank_you
  end

  private

  def secure_params
    params.require(:licensee_application).permit(:first_name, :last_name, :email, :phone, :interested_locations, :comments)
  end
end
