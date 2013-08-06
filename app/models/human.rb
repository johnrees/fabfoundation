class Human < ActiveRecord::Base
  belongs_to :user
  belongs_to :lab
  bitmask :roles, :as => [:student, :staff, :manager]
end
