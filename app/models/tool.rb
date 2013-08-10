class Tool < ActiveRecord::Base
  belongs_to :lab
  belongs_to :tool_type

  validates_presence_of :name, :tool_type

  def to_s
    name
  end
end
