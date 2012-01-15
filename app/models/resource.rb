class Resource < ActiveRecord::Base
  belongs_to :class_room
  belongs_to :user
  
  has_attached_file :file
  
  validates_attachment_size :file, less_than: 5.megabyte
  
end
