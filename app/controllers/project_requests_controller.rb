class ProjectRequestsController < ApplicationController

  layout 'landing'

  def new
    @project_request = ProjectRequest.new
  end

  def create
    @project_request = ProjectRequest.new(secure_params)
    if @project_request.save
      redirect_to request_received_path
    else
      render :new
    end
  end

  def request_received
  end

  private

  def secure_params
    params.require(:project_request).permit(:name, :email, :phone, :zip, :size)
  end
end
