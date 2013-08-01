class Lab < ActiveRecord::Base
  include Authority::Abilities
  self.authorizer_name = 'LabAuthorizer'

  validates_presence_of :name

  def to_s
    name
  end

  def country
    country_code.present? ? Carmen::Country.coded(country_code).name : ""
  end

end
