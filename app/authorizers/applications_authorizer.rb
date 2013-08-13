class ApplicationsAuthorizer < ApplicationAuthorizer

  def creatable_by?(user)
    user
  end
end
