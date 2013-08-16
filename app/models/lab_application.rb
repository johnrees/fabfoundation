class LabApplication < ActiveRecord::Base
  include Authority::Abilities
  self.authorizer_name = 'LabApplicationAuthorizer'

  belongs_to :lab
  belongs_to :creator
  accepts_nested_attributes_for :lab

  state_machine :initial => :new do
    event :approve do
      transition :new => :approved
    end
  end

end