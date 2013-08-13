class Application < ActiveRecord::Base
  belongs_to :lab
  belongs_to :creator
end
