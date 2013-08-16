class Comment < ActiveRecord::Base
  has_ancestry
  belongs_to :commentable, polymorphic: true
  validates_presence_of :content, :commentable
end
