class User < ActiveRecord::Base

  include Authority::UserAbilities
  include Authority::Abilities
  self.authorizer_name = 'UserAuthorizer'
  has_secure_password validations: false

  has_many :humans
  has_many :labs, through: :humans

  has_many :labs, foreign_key: 'creator_id'
  has_many :events, foreign_key: 'creator_id'

  validates_length_of :password, minimum: 5, allow_blank: true
  # validates :password, allow_blank: true, on: :create

  validates_presence_of :first_name, :last_name, :email, on: 'create'
  validates :email, uniqueness: true, format: /@/

  before_create { generate_token(:action_token) }
  after_create :complete_registration

  def location
    "#{city}, #{country}"
  end

  def country
    country_code.present? ? country_code : ""
  end

  def managed_labs
    labs
  end

  def to_s
    full_name
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def avatar_image
    avatar || "http://www.murketing.com/journal/wp-content/uploads/2009/04/vimeo.jpg"
  end

private

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def complete_registration
    UserMailer.complete_registration(self).deliver
  end

end
