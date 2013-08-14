class LabApplicationAuthorizer < ApplicationAuthorizer

  def self.creatable_by? user
    user.persisted?
  end

end
