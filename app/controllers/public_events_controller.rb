class PublicEventsController < ApplicationController
  def index
    @public_classes = PublicEvent.all
  end

  def new
    @public_event = PublicEvent.new
    @experiences = Experience.all
    @locations   = Location.all
    @artists     = Artist.all
  end

  def create
    event = PublicEvent.new(public_event_params)
    if event.save
      redirect_to(event)
    else
      # render :new
      # flash[:notice] = "Unsucessful, please try again"
    end
  end

  def show
    @public_event = PublicEvent.find(params[:id])
  end

  private
  def public_event_params
    params.require(:public_event).permit(:name, :event_type, :description, :venue, :artist_id, :image, :date, :start_time, :end_time, :price, :live, :available_slots)
  end
end
