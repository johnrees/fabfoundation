class EventsController < ApplicationController
  authorize_actions_for Event

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

end
