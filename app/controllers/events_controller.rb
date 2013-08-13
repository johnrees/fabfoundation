class EventsController < ApplicationController
  authorize_actions_for Event

  def calendar
    @events = Event.all
  end
  authority_actions calendar: 'read'

  def index
    @events = Event.all
    @event_days = @events.group_by { |e| e.starts_at.beginning_of_day }
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = current_user.events.new
  end

  def edit
    @event = current_user.events.find(params[:id])
  end

  def create
    @event = current_user.events.build event_params
    if @event.save
      redirect_to event_url(@event)
    else
      render :new
    end
  end

  def update
    @event = current_user.events.find(params[:id])
    if @event.update_attributes event_params
      redirect_to event_url(@event)
    else
      render :edit
    end
  end

private

  def event_params
    params.require(:event).permit(:name, :details, :lab_id, :starts_at, :image, :ends_at)
  end

end
