class User < ActiveRecord::Base

  authenticates_with_sorcery!
  include Authority::UserAbilities
  include Authority::Abilities
  self.authorizer_name = 'UserAuthorizer'

  has_many :humans
  has_many :labs, through: :humans

  validates_format_of :email, :with => /@/

  def managed_labs
    labs
  end

  def to_s
    username
  end

  def admin?
    username == "admin"
  end

end
