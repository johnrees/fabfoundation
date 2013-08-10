class LabAuthorizer < ApplicationAuthorizer

  def self.creatable_by? user
    user.persisted?
  end

  def self.readable_by?(user)
    true
  end

  def self.updatable_by?(user)
    user
  end

  def updatable_by?(user)
    user and user.labs.include? resource
  end

end
