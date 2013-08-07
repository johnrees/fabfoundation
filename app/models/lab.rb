class Lab < ActiveRecord::Base

  has_paper_trail

  belongs_to :creator, class_name: "User"
  has_many :events
  has_many :humans
  has_many :users, through: :humans

  include Authority::Abilities
  self.authorizer_name = 'LabAuthorizer'

  validates_presence_of :name

  after_create :lab_submission_confirmation

  def lab_submission_confirmation
    UserMailer.lab_submission_confirmation(self).deliver
  end

  def to_s
    name
  end

  def country
    country_code.present? ? Carmen::Country.coded(country_code).name : ""
  end

end
