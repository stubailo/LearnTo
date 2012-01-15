class Resource < ActiveRecord::Base
  belongs_to :class_room
  belongs_to :user
  
  has_attached_file :file, :path => ":rails_root/public/system/:id/:filename"
  
  def add_url
	self.url = "/system/#{self.id}/#{self.file_file_name}"
	save
  end
  
  validates_attachment_size :file, less_than: 5.megabyte
  
end
