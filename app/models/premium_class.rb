class PremiumClass < ActiveRecord::Base
  belongs_to :class_room
  
  has_attached_file :image, :styles => { :full_width => "940x400^"}

end
