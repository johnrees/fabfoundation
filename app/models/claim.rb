class Claim < ActiveRecord::Base
  belongs_to :user
  belongs_to :lab

  validates_presence_of :details, :user, :lab
  validates_uniqueness_of :lab_id, scope: :user_id

  state_machine :initial => :new do
    event :approve do
      transition :new => :approved
    end
    before_transition :new => :approved do |claim, transition|
      claim.user.labs << claim.lab
    end
  end

  after_create :notify_existing_users

private

  def notify_existing_users
    lab.users.each do |user|
      UserMailer.new_claimant(user).deliver
    end
  end

end
