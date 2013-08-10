class Event < ActiveRecord::Base
  include Authority::Abilities
  self.authorizer_name = 'EventAuthorizer'

  belongs_to :lab
  belongs_to :creator, class_name: "User"
  validates_presence_of :name, :lab, :starts_at

  def to_s
    name
  end

  def to_param
    "#{id} #{name} at #{lab}".parameterize
  end

end
