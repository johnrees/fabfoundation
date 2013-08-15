class Application < ActiveRecord::Base
  belongs_to :lab
  belongs_to :creator

  validates_presence_of :creator
  validates_presence_of :lab
end
