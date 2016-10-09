class ProjectRequestsController < ApplicationController

  layout 'application_alt'

  def new
    @project_request = ProjectRequest.new
  end

  def create
    @project_request = ProjectRequest.build(secure_params)
    if @project_requests.save
    else
    end
  end

  private

  def secure_params
    params.require(:project_request).permit(:name, :email, :phone, :zip, :size)
  end
end
