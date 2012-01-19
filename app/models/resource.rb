class Resource < ActiveRecord::Base
  belongs_to :class_room
  belongs_to :user
  belongs_to :document
  belongs_to :resource
  has_one :document
  has_one :homework_resource
  
  has_attached_file :file, :styles => Proc.new { |a| a.instance.file_styles(a) }
  
  def file_styles(a)
    type = a.content_type
	if(type.start_with? "image")	
	  return { :medium => "300x300>", :thumb => "100x100>" }
	else
	  return {}
	end
  end
 
  # never change these names, or the order, ever :D
  TYPES = ['upload', 'link', 'document']
  
  validates_attachment_size :file, less_than: 5.megabyte
  
end
