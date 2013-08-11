class Backstage::EventsController < Backstage::BackstageController

  authorize_actions_for Event

  def new
    @event = Event.new
  end

  def show
  end

  def index
    @events = Event.all
  end

  def edit
    @event = Event.find(params[:id])
  end

  def create
    @event = Event.create event_params
    if @event.save
      redirect_to backstage_events_path, notice: "Event Added"
    else
      render :new
    end
  end

  def update
    @event = Event.find(params[:id])
    if @event.update_attributes event_params
      redirect_to backstage_events_url, notice: "Event Updated"
    else
      render :edit
    end
  end

private

  def event_params
    params.require(:event).permit!
  end

end
