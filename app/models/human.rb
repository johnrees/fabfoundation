class Human < ActiveRecord::Base
  belongs_to :user
  belongs_to :lab
  bitmask :roles, :as => [:student, :staff, :manager]

  validates_presence_of :lab
  # validates_uniqueness_of :user_id, scope: :lab_id

  def name
    user.present? ? user.full_name : full_name
  end

  def to_s
    name
  end

  def avatar
    user.present? ? user.avatar_image : asset_path('/assets/default-avatar.png')
  end

end
