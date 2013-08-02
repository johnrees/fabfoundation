class UserAuthorizer < ApplicationAuthorizer

  def self.readable_by?(user)
    true
  end

  def self.creatable_by?(user)
    user.new_record?
  end

end
