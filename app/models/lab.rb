class Lab < ActiveRecord::Base

  include Authority::Abilities
  self.authorizer_name = 'LabAuthorizer'

  bitmask :kind, :as => [:planned_fab_lab, :mini_fab_lab, :fab_lab, :supernode]

  has_paper_trail
  has_ancestry

  belongs_to :creator, class_name: "User"
  has_many :events
  has_many :humans
  has_many :tools
  has_many :opening_times
  accepts_nested_attributes_for :tools, :reject_if => :all_blank, :allow_destroy => true

  has_many :users, through: :humans

  geocoded_by :address
  after_validation :geocode

  has_and_belongs_to_many :referee_labs,
    :association_foreign_key => 'referee_id',
    :class_name => 'Lab',
    :join_table => 'referees'

  validates_presence_of :name, :address, :kind
  validates_uniqueness_of :name

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
    country_code.present? ? country_code : ""
  end

private

  def new_lab_notification
    UserMailer.lab_submission_confirmation(self).deliver
    AdminMailer.new_lab_added(self).deliver
  end

end
