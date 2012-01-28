class Announcement < ActiveRecord::Base
  belongs_to :user
  belongs_to :class_room
  
  has_many :notifications, :as => :item, :dependent => :destroy
end
