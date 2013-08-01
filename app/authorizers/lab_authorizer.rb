class LabAuthorizer < ApplicationAuthorizer

  def self.creatable_by?(user)
    user.persisted?
  end

  def self.readable_by?(user)
    true
  end

  def self.updatable_by?(user)
    user.persisted?
  end

end
