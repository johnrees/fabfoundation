class EventAuthorizer < ApplicationAuthorizer

  # def self.creatable_by?(user)
  #   user and !user.labs.empty?
  # end

  def self.creatable_by?(user)
    user.labs.any?
  end

  def self.updatable_by?(user)
    # resource.lab.humans.include? user
    # resource.creator == user
    # user.labs.include? resource.lab
    true
  end

  def self.readable_by?(user)
    true
  end

end
