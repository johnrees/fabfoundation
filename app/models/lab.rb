class Lab < ActiveRecord::Base

  include Authority::Abilities
  self.authorizer_name = 'LabAuthorizer'

  state_machine :initial => :new do
    event :approve do
      transition :new => :approved
    end
  end

  before_save :get_time_zone
  def get_time_zone
    if Rails.env.test?
      self.time_zone = 'Europe/London'
    else
      self.time_zone = GoogleTimezone.fetch(latitude, longitude).time_zone_id
    end
  end

  # class BitwiseOpeningTimes

  #   def load(text)
  #     return unless text
  #     text.unpack('m').first
  #   end

  #   def dump(text)
  #     b = Bitwise.new
  #     %w(monday tuesday wednesday thursday friday saturday sunday).each do |day|
  #       b.indexes << opening_hours[day][0]
  #       b.indexes << opening_hours[day][1]
  #     end
  #     self.opening_hours_bitmask = b.bits
  #   end

  # end

  # serialize :opening_hours_bitmask, BitwiseHours.new

  def opening_hours=(opening_hours)
    b = Bitwise.new
    %w(monday tuesday wednesday thursday friday saturday sunday).each do |day|
      b.indexes << opening_hours[day][0]
      b.indexes << opening_hours[day][1]
    end
    self.opening_hours_bitmask = b.bits
  end

  def opening_hours
    if opening_hours
      b = Bitwise.new
      %w(monday tuesday wednesday thursday friday saturday sunday).each do |day|
        opening_hours[day][0] =
        b.indexes << opening_hours[day][1]
      end
      self.opening_hours_bitmask = b.bits
    end
  end

  default_scope { with_state(:approved) }

  Kinds = %w[planned_fab_lab mini_fab_lab fab_lab supernode]
  # bitmask :kind, :as => [:planned_fab_lab, :mini_fab_lab, :fab_lab, :supernode]

  has_paper_trail
  has_ancestry


  belongs_to :creator, class_name: "User"
  has_many :events

  has_one :lab_application
  has_many :tools
  has_many :opening_times
  accepts_nested_attributes_for :tools,
    :reject_if => proc { |a| a['name'].blank? },
    :allow_destroy => true

  has_many :humans
  has_many :users, through: :humans
  accepts_nested_attributes_for :humans,
    :reject_if => proc { |a| a['user_id'].blank? },
    :allow_destroy => true

  # geocoded_by :address
  # after_validation :geocode

  # acts_as_mappable :default_units => :miles,
  #                  :default_formula => :sphere,
  #                  :distance_field_name => :distance,
  #                  :lat_column_name => :latitude,
  #                  :lng_column_name => :longitude

  before_save :country_stuff

  has_and_belongs_to_many :referee_labs,
    :association_foreign_key => 'referee_id',
    :class_name => 'Lab',
    :join_table => 'referees'

  validates :email, format: /@/, allow_blank: true
  # validates_inclusion_of :time_zone, in: ActiveSupport::TimeZone.zones_map(&:name), allow_blank: true
  validates_presence_of :name, :country_code, :city
  validates_uniqueness_of :name

  def kind_string
    Kinds[kind] ? Kinds[kind] : ""
  end

  def address
    [street_address_1, street_address_2, city, postal_code, country].reject!(&:blank?).join("\n")
  end

  def short_address
    "#{city}, #{country}"
  end

  def websites
    urls.present? ? urls.lines.map(&:chomp) : []
  end

  # after_create :new_lab_notification
  def to_s
    name
  end

  def to_param
    "#{id} #{name}".parameterize
  end

  def country
    if country_code.present? and Country[country_code]
      Country[country_code].name
    else
      ""
    end
  end

private

  def new_lab_notification
    UserMailer.lab_submission_confirmation(self).deliver
    AdminMailer.new_lab_added(self).deliver
  end

  def country_stuff
    self.country_code.downcase!
    self.region = Country[country_code].try(:region) ? Country[country_code].region : nil
    self.subregion = Country[country_code].try(:subregion) ? Country[country_code].subregion : nil
  end

  def after_approve(lab, transition)
    UserMailer.lab_approval_notification(lab).deliver
  end

end
