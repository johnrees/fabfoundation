class Lab < ActiveRecord::Base

  extend FriendlyId

  friendly_id :slug_candidates, use: :slugged

  belongs_to :creator, class_name: "User"
  has_one :lab_application
  has_many :claims
  has_many :events
  has_many :tools
  has_many :humans
  # has_many :users, through: :humans
  has_and_belongs_to_many :facilities

  has_many :labs_users
  has_many :users, through: :labs_users

  default_scope -> { where(state: 'approved') }

  accepts_nested_attributes_for :tools,
    :reject_if => proc { |a| a['name'].blank? },
    :allow_destroy => true

  accepts_nested_attributes_for :humans,
    :reject_if => proc { |a| a['full_name'].blank? },
    :allow_destroy => true

  has_paper_trail
  has_ancestry

  scope :approved, -> { where(state: 'approved') }

  Kinds = %w[planned_fab_lab mini_fab_lab fab_lab supernode]

  attr_accessor :has_opening_hours

  geocoded_by :address

  before_save :country_stuff


  validates :email, format: /@/, allow_blank: true
  validates_presence_of :name, :country_code
  validates_uniqueness_of :name

  attr_accessor :thing

  def slug_candidates
    [
      :name,
      [:name, :country],
      [:name, :city, :country]
    ]
  end

  def self.supernodes
    where(kind: 3)
  end

  def supernode?
    has_children?
  end

  state_machine :initial => :new do
    event :approve do
      transition :new => :approved
    end
  end
  # after_create :new_lab_notification

  before_save :get_time_zone
  def get_time_zone
    if Rails.env.test?
      self.time_zone ||= 'Europe/London'
    else
      begin
        self.time_zone = GoogleTimezone.fetch(latitude, longitude).time_zone_id
      rescue
      end
    end
  end

  def kind_string
    kind.present? ? Kinds[kind] : "fab_lab"
  end

  def latlng
    "#{latitude}, #{longitude}"
  end

  def address
    [street_address_1, street_address_2, city, postal_code, country].reject(&:blank?).join("\n")
  end

  def short_address
    "#{city}, #{country}"
  end

  def websites
    urls.present? ? urls.lines.map(&:chomp) : []
  end

  def to_s
    name
  end

  def country
    if country_code.present? and Country[country_code]
      Country[country_code].name
    else
      ""
    end
  end

  def avatar_image
    avatar.present? ? avatar : "http://i.imgur.com/K1EeMmp.jpg"#asset_path('/assets/default-lab-image.jpg')
  end

private

  def country_stuff
    if country_code.present?
      self.country_code.downcase!
      self.region = Country[country_code].try(:region) ? Country[country_code].region : nil
      self.subregion = Country[country_code].try(:subregion) ? Country[country_code].subregion : nil
    end
  end

  def after_approve(lab, transition)
    UserMailer.lab_approval_notification(lab).deliver
  end

end
