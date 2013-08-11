class EventAuthorizer < ApplicationAuthorizer

  # def self.creatable_by?(user)
  #   user and !user.labs.empty?
  # end

  def creatable_by?(user)
    user.admin?
    # resource.lab.humans.include? user
  end

  def updatable_by?(user)
    # resource.lab.humans.include? user
    resource.creator == user
  end

  def self.readable_by?(user)
    true
  end

end
