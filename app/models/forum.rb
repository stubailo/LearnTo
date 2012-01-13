class Forum < ActiveRecord::Base
  has_many :posts
  belongs_to :class_room
end
