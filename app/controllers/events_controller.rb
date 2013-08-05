class EventsController < ApplicationController
  authorize_actions_for Event

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def edit
    @event = Event.find(params[:id])
  end

  def create
    @event = Event.new event_params
    if @event.save
      redirect_to event_url(@event)
    else
      render :new
    end
  end

  def update
    @event = Event.find(params[:id])
    if @event.update_attributes event_params
      redirect_to event_url(@event)
    else
      render :edit
    end
  end

private

  def event_params
    params.require(:event).permit(:name, :details, :lab_id, :starts_at)
  end

end
