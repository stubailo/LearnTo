class Resource < ActiveRecord::Base
  belongs_to :class_room
  belongs_to :user
  
  has_attached_file :file, :styles => Proc.new { |a| a.instance.file_styles(a) }
  
  def file_styles(a)
    type = a.content_type
    puts "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
    puts type
	if(type.start_with? "image")	
	  return { :medium => "300x300>", :thumb => "100x100>" }
	else
	  return {}
	end
  end
  
  validates_attachment_size :file, less_than: 5.megabyte
  
end
