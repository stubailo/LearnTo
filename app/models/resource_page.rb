class ResourcePage < ActiveRecord::Base
  belongs_to :class_room
  has_many :sections
  
  SECTIONS = ['lessons', 'homework', 'materials', 'quizzes']
end
