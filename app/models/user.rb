class User < ActiveRecord::Base
  authenticates_with_sorcery!
  include Authority::UserAbilities
  validates_format_of :email, :with => /@/

  def to_s
    email
  end

  def admin?
    username == "admin"
  end
end
