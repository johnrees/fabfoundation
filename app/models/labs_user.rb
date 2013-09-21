class LabsUser < ActiveRecord::Base
  belongs_to :lab
  belongs_to :user
  validates_uniqueness_of :lab_id, scope: :user_id
end
