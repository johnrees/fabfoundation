class EventAuthorizer < ApplicationAuthorizer

  def self.creatable_by?(user)
    user.persisted?
  end

  def creatable_by?(user)
    false
    # resource.lab.humans.include? user
  end

  def updatable_by?(user)
    resource.lab.humans.include? user
  end

  def self.readable_by?(user)
    true
  end

end
