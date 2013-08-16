class Referee < ActiveRecord::Base
  belongs_to :lab_application
  belongs_to :applicant
end
