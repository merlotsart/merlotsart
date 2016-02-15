class PrivateEventsController < ApplicationController
  def index
    @private_classes = PrivateEvent.all
  end

  def new
    @private_event = PrivateEvent.new
  end

  def create
    event = PrivateEvent.new(private_event_params)
    if event.save
      UserMailer.private_event(event).deliver_now
      redirect_to private_event_path(event)
    else
      flash[:notice] = "Sorry your request was not sent.  Please make your corrections and resend."
      @private_event = event
      render :new
    end
  end

  def show
    @private_event = PrivateEvent.find(params[:id])
  end

  private

  def private_event_params
    params.require(:private_event).permit(:name, :description, :date, :start_time, :end_time, :live, :available_slots, :event_type, :phone, :email, :how_hear, :employee_referral, :special_request)
  end
end
