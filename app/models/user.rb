class User < ActiveRecord::Base

  authenticates_with_sorcery!
  include Authority::UserAbilities
  include Authority::Abilities

  self.authorizer_name = 'UserAuthorizer'

  has_many :humans
  has_many :labs, through: :humans

  has_many :labs, foreign_key: 'creator_id'
  has_many :events, foreign_key: 'creator_id'

  validates_format_of :email, :with => /@/

  after_create :welcome

  def add_lab lab
    labs << lab
  end

  def welcome
    UserMailer.welcome(self).deliver
  end

  def managed_labs
    labs
  end

  def to_s
    email
  end

  def admin?
    email == "admin@admin.com"
  end

end
