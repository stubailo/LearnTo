class Subcomment < ActiveRecord::Base
  belongs_to :user
  belongs_to :comment
  validates :user_id, :presence => true
  validates :content, :presence => true
end
