class ToolType < ActiveRecord::Base
  has_many :tools
  default_scope { order('slug ASC') }
  def to_s
    name
  end
end
