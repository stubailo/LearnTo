class Forum < ActiveRecord::Base
  belongs_to :class_room
  has_many :posts, :dependent => :destroy
end
