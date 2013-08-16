class UserAuthorizer < ApplicationAuthorizer

  def self.readable_by? user
    true
  end

  def self.updatable_by? user
    true
  end

  def updatable_by? user
    user
  end

  def self.creatable_by? user
    # !user.persisted?
    true
  end

end
