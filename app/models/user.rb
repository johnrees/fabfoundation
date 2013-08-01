class User < ActiveRecord::Base
  authenticates_with_sorcery!
  validates_format_of :email, :with => /@/
end
