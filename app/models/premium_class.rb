class PremiumClass < ActiveRecord::Base
  belongs_to :class_room
  
  if Rails.env == "production"
    has_attached_file :image, :styles => { :full_width => "940x400^"},
      :storage => :s3, 
      :s3_credentials => "#{Rails.root}/config/s3.yml", 
      :path => "/:style/:id/:filename"
  else
    has_attached_file :file, :styles => { :full_width => "940x400^"}
  end

end
