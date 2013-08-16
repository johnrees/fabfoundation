class User < ActiveRecord::Base

  include Authority::UserAbilities
  include Authority::Abilities
  self.authorizer_name = 'UserAuthorizer'
  has_secure_password validations: false

  state_machine :initial => :new do

    event :signup do
      transition :new => :signed_up
    end

    event :invite do
      transition :new => :invited
    end

    event :confirm do
      transition [:signed_up, :invited] => :confirmed
    end

  end

  has_many :humans
  has_many :labs, through: :humans

  has_many :labs, foreign_key: 'creator_id'
  has_many :events, foreign_key: 'creator_id'
  has_many :lab_applications, foreign_key: 'creator_id'

  validates :password,
    :presence     => true,
    :length       => { :minimum => 5 },
    :on => :update
    # :if           => :password

  # validates :password, allow_blank: true, on: :create

  validates_presence_of :first_name, :last_name, :email
  validates :email, uniqueness: true, format: /@/
  validates :public_email, format: /@/, allow_blank: true

  before_save { generate_token(:action_token) }
  after_create :complete_registration
  before_create :check_password

  def check_password
    self.password ||= SecureRandom.urlsafe_base64
  end

  def location
    "#{city}, #{country}" if city.present?
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
