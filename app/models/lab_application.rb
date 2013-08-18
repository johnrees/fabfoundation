class LabApplication < ActiveRecord::Base
  # include Authority::Abilities
  # self.authorizer_name = 'LabApplicationAuthorizer'

  belongs_to :lab
  belongs_to :creator, class_name: "User"
  accepts_nested_attributes_for :lab

  has_many :referees
  has_many :labs, through: :referees
  # # :association_foreign_key => 'applicant_id',
  # :class_name => 'Lab',
  # :join_table => 'referees'

  validate :has_referee_labs?
  def has_referee_labs?
    errors.add(:base, 'Lab Application must have at least one referee') if self.labs.blank?
  end

  state_machine :initial => :new do
    event :approve do
      transition :new => :approved
    end
  end

end
