class ExperiencesController < ApplicationController
  def index
    @month_param    = params[:month].to_i
    @year           = Time.now.year
    # need to change years
    @experience     = params[:experience_id].to_i
    @location       = params[:location_id].to_i
    @current_month  = Date::MONTHNAMES[@month_param]
    @next_month     = Date::MONTHNAMES[@month_param+1]
    @previous_month = Date::MONTHNAMES[@month_param-1]
    @experiences    = Experience.all
    @locations      = Location.all
    if (@experience == 0) && (@location == 0)
      @public_events  = PublicEvent.where('extract(month from date) = ?', @month_param).where(live: true).order(:date)
    elsif @experience == 0
      @public_events  = PublicEvent.where('extract(month from date) = ?', @month_param).where(live: true).where(location_id: @location).order(:date)
    elsif @location == 0
      @public_events  = PublicEvent.where('extract(month from date) = ?', @month_param).where(live: true).where(experience_id: @experience).order(:date)
    end
  end
end
