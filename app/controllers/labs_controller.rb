class LabsController < ApplicationController

  before_filter :require_login, except: [:index, :show, :map]
  # authorize_actions_for Lab

  [:map, :index].each do |method|
    define_method method do
      @q = Lab.order('name ASC').includes(:tools => :tool_type, :humans => :user).search(params[:q])
      @labs = @q.result(distinct: true)

      @continents = Hash.new(0)
      @regions = Hash.new(0)
      @tool_types = Hash.new(0)
      @lab_kinds = Hash.new(0)


      @labs.each do |lab|

        if Country[lab.country_code].try(:continent)
          @continents[ Country[lab.country_code].continent ] += 1
        end

        if lab.region.present?
          @regions[lab.region] += 1
        end

        # lab.tools.map(&:tool_type).each do |tool_type|
        #   @tool_types[tool_type.name] += 1
        # end

        if lab.kind.present?
          @lab_kinds[Lab::Kinds[lab.kind]] += 1
        end

      end

      # @labs = @labs.page(params[:page])
      @lab_countries = @labs.group_by{ |l| l.country_code }

    end
  end
  # authority_actions map: 'read'

  def edit
    @lab = current_user.labs.friendly.find(params[:id])
    @lab.tools.build
    @lab.humans.build
    # authorize_action_for(@lab)
  end

  def update
    @lab = current_user.labs.friendly.find(params[:id])
    if @lab.update_attributes lab_params
      redirect_to lab_url(@lab), notice: "Lab Updated"
    else
      render :edit
    end
  end

  def show
    @lab = Lab.friendly.find(params[:id])
    @days = %w(monday tuesday wednesday thursday friday saturday sunday)

    @sections = %w(location)
    # @sections.push 'events' if @lab.events.any?
    @sections.push 'nearby' if @lab.geocoded?
    # @sections.push 'equipment' if @lab.tools.any?
    @sections.push 'people' if @lab.humans.any?
  end

private

  def lab_params
    params.require(:lab).permit(
      #referees
      :avatar,
      :name, :kind, :description,
      :urls, :email, :parent_id,
      :country_code, :street_address_1, :street_address_2,
      :city, :region, :postal_code, :address_notes, :phone,
      :latitude, :longitude, :opening_hours_notes, :application_notes, :time_zone,
      facility_ids: [], opening_hours: [],
      tools_attributes: [:id, :tool_type_id, :name, :description, :photo, :_destroy],
      humans_attributes: [:id, :user_id, :details, :_destroy]
    )
  end

end
