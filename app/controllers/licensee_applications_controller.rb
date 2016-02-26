class LicenseeApplicationsController < ApplicationController

  def new
    @licensee_application = LicenseeApplication.new

    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @licensee_application = LicenseeApplication.create(secure_params)

    if @licensee_application.save
      respond_to do |format|
        format.html
        format.js
      end
    else
      respond_to do |format|
        format.html
        format.js
      end
    end
  end

  private

  def secure_params
    params.require(:model).permit(:attrs)
  end
end
