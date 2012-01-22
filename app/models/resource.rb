class Resource < ActiveRecord::Base
  belongs_to :class_room
  belongs_to :user
  belongs_to :document
  belongs_to :resource
  belongs_to :section
  has_one :document
  
  if Rails.env == "Production"
    has_attached_file :file, :styles => Proc.new { |a| a.instance.file_styles(a) }, 
      :storage => :s3, 
      :s3_credentials => "#{Rails.root}/config/s3.yml", 
      :path => "/:style/:id/:filename"
  else
    has_attached_file :file, :styles => Proc.new { |a| a.instance.file_styles(a) }
  end
  
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
  
  validates_attachment_size :file, less_than: 10.megabyte
  
end
