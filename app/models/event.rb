class Event < ActiveRecord::Base

  # include Authority::Abilities
  # self.authorizer_name = 'EventAuthorizer'

  extend SplitDatetime::Accessors
  accepts_split_datetime_for :starts_at, :ends_at

  belongs_to :lab
  belongs_to :creator, class_name: "User"
  validates_presence_of :name, :lab, :starts_at

  before_save :set_time_in_utc

  # def starts_at
  #   if new_record?
  #     DateTime.now
  #   else
  #     Time.zone = lab.time_zone
  #     Time.zone.utc_to_local @starts_at
  #   end
  # end

  # def ends_at
  #   if new_record?
  #     super
  #   else
  #     Time.zone = lab.time_zone
  #     Time.zone.utc_to_local @ends_at
  #   end
  # end

  def set_time_in_utc
    Time.zone = lab.time_zone
    self.starts_at = Time.zone.local_to_utc starts_at
    self.ends_at = Time.zone.local_to_utc ends_at
  end

  def to_s
    name
  end

  def to_param
    "#{id} #{name} at #{lab}".parameterize
  end

end
