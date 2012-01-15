class Resource < ActiveRecord::Base
  belongs_to :class_room
  belongs_to :user
  
  has_attached_file :file, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  
  validates_attachment_size :file, less_than: 5.megabyte
  
end
