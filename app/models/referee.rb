class Referee < ActiveRecord::Base
  belongs_to :lab
  belongs_to :applicant
end
