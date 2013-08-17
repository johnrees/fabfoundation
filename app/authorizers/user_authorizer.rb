class UserAuthorizer < ApplicationAuthorizer

  def self.readable_by? user
    true
  end

  def self.updatable_by? user
    user == resource
  end

  def self.creatable_by? user
    # !user.persisted?
    true
  end

end
