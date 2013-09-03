class EventsController < ApplicationController

  def calendar
    @events = Event.all
    authorize :read, @events
  end

  def index
    @events = Event.all
    @event_days = @events.group_by { |e| e.starts_at.beginning_of_day }
    authorize :read, @events
  end

  def show
    @event = Event.find(params[:id])
    authorize :read, @event
  end

  def new
    @event = current_user.events.new
    authorize :create, @event
  end

  def edit
    @event = current_user.events.find(params[:id])
    authorize :update, @event
  end

  def create
    @event = current_user.events.build event_params
    authorize :create, @event
    if @event.save
      redirect_to event_url(@event)
    else
      render :new
    end
  end

  def update
    @event = current_user.events.find(params[:id])
    authorize :update, @event
    if @event.update_attributes event_params
      redirect_to event_url(@event)
    else
      render :edit
    end
  end

private

  def event_params
    params.require(:event).permit(
      :name,
      :details,
      :lab_id,
      :image,
      :starts_at_date,
      :starts_at_hour,
      :ends_at_date,
      :ends_at_hour,
      :all_day
    )
  end

end
