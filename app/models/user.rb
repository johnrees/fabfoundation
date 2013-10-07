include ActionView::Helpers::AssetTagHelper

class User < ActiveRecord::Base

  # include Authority::UserAbilities
  # include Authority::Abilities
  # self.authorizer_name = 'UserAuthorizer'
  has_secure_password validations: false

  has_many :claims

  attr_accessor :current_password

  state_machine :initial => :new do

    event :signup do
      transition :new => :signed_up
    end

    event :invite do
      transition :new => :invited
    end

    event :confirm do
      transition [:new, :invited, :signed_up] => :confirmed
    end

    state :invited do
      # validates :password, presence: true, length: { minimum: 6 }
      validate :password,
        length: { minimum: 6 },
        presence: true
        # allow_nil: true
    end

    # state :confirmed do
    #   validates_confirmation_of :password, if: lambda { |m| m.password.present? }
    # end

    after_transition :new => :invited do |user|
      UserMailer.complete_registration(user).deliver
    end

    after_transition :invited => :confirmed do |user|
      UserMailer.welcome(user).deliver
    end

  end

  has_many :humans
  # has_many :labs, through: :humans

  has_many :created_labs, foreign_key: 'creator_id', class_name: 'Lab'
  has_many :events, foreign_key: 'creator_id'
  has_many :lab_applications, foreign_key: 'creator_id'
  has_many :labs_users
  has_many :labs, through: :labs_users


  # validates_presence_of :password




  validates_presence_of :first_name, :last_name, :email
  validates :email, uniqueness: true, format: /@/
  validates :public_email, format: /@/, allow_blank: true

  # validates :password,
  #   presence: true,
  #   # confirmation: true,
  #   length: { minimum: 6 },
  #   on: :update,
  #   # allow_nil: true,
  #   allow_nil: true
  #   # if: lambda { password.present? }


  before_create { generate_token(:invite_token) }
  before_update { reset_tokens }

  # after_create :complete_registration
  before_create :check_password

  def manages_lab? lab
    labs.exclude?(lab)
  end

  def claimed_lab? lab
    !claims.where(lab: lab).exists?
  end

  def send_password_reset
    generate_token(:forgot_password_token)
    save!(validate: false)
    UserMailer.password_reset(self).deliver
  end

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
    avatar.present? ? avatar : "http://www.natcen.ac.uk/css-images/default_user.png"#asset_path('/assets/default-avatar.png')
  end

private

  def reset_tokens
    if password_digest_changed?
      generate_token(:invite_token)
      generate_token(:forgot_password_token)
    end
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def complete_registration
    invite
  end

end
