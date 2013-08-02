class Event < ActiveRecord::Base

  belongs_to :lab
  include Authority::Abilities
  self.authorizer_name = 'EventAuthorizer'

  validates_presence_of :name, :starts_at, :lab

  def to_s
    name
  end

end
