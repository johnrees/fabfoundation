class LabApplication < ActiveRecord::Base

  belongs_to :lab
  belongs_to :creator, class_name: "User"
  accepts_nested_attributes_for :lab

  has_many :referees
  has_many :labs, through: :referees
  after_create :deliver_lab_application_notifications

  # validate :has_referee_labs?
  def has_referee_labs?
    errors.add(:base, 'Lab Application must have at least one referee') if self.labs.blank?
  end

  state_machine :initial => :new do
    event :approve do
      transition :new => :approved
    end

    after_transition :new => :approved do |lab_application|
      UserMailer.lab_application_approval(lab_application).deliver
    end
  end

private

  def deliver_lab_application_notifications
    UserMailer.lab_application_submission(self).deliver
    AdminMailer.lab_application_submission(self).deliver
  end

end
