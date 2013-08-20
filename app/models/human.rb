class Human < ActiveRecord::Base
  belongs_to :user
  belongs_to :lab
  bitmask :roles, :as => [:student, :staff, :manager]

  validates_presence_of :lab
  validates_uniqueness_of :user_id, scope: :lab_id

  def name
    user.present? ? user.name : full_name
  end

end
