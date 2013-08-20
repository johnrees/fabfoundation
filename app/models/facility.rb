class Facility < ActiveRecord::Base
  has_and_belongs_to_many :labs
  default_scope { order(:name) }

  def to_s
    name
  end

  def icon
    "/assets/facilities/#{name.parameterize}.svg"
  end

end
