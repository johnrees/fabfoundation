class Event < ActiveRecord::Base

  belongs_to :lab
  include Authority::Abilities
  self.authorizer_name = 'EventAuthorizer'

  validates_presence_of :name, :lab, :starts_at

  def to_s
    name
  end

  def to_param
    "#{id} #{name} at #{lab}".parameterize
  end

end
