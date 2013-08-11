class Lab < ActiveRecord::Base

  include Authority::Abilities
  self.authorizer_name = 'LabAuthorizer'

  States = {
    :new => 0,
    :approved => 1
  }

  state_machine :initial => :new do
    States.each do |name, value|
      state name, value: value
    end

    event :approve do
      transition all => :approved
    end
  end

  def after_approve(lab, transition)
    UserMailer.lab_approval_notification(lab).deliver
  end

  # default_scope { with_state(:approved) }

  Kinds = %w[planned_fab_lab mini_fab_lab fab_lab supernode]
  # bitmask :kind, :as => [:planned_fab_lab, :mini_fab_lab, :fab_lab, :supernode]

  has_paper_trail
  has_ancestry

  belongs_to :creator, class_name: "User"
  has_many :events
  has_many :humans
  has_many :tools
  has_many :opening_times
  accepts_nested_attributes_for :tools,
    :reject_if => proc { |a| a['name'].blank? },
    :allow_destroy => true

  has_many :users, through: :humans

  # geocoded_by :address
  # after_validation :geocode

  before_save :country_stuff

  has_and_belongs_to_many :referee_labs,
    :association_foreign_key => 'referee_id',
    :class_name => 'Lab',
    :join_table => 'referees'

  validates_inclusion_of :time_zone, in: ActiveSupport::TimeZone.zones_map(&:name), allow_blank: true
  # validates_presence_of :name, :kind, :country_code, :city
  # validates_uniqueness_of :name

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
    country_code.present? ? Country[country_code].name : ""
  end

private

  def new_lab_notification
    UserMailer.lab_submission_confirmation(self).deliver
    AdminMailer.new_lab_added(self).deliver
  end

  def country_stuff
    self.country_code.upcase!
    self.region = Country[country_code].try(:region) ? Country[country_code].region : nil
    self.subregion = Country[country_code].try(:subregion) ? Country[country_code].subregion : nil
  end

end
