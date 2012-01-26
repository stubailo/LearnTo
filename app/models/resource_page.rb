class ResourcePage < ActiveRecord::Base
  validates :section, :presence => true

  belongs_to :class_room
  has_many :sections, :dependent => :destroy
  has_many :resources, :through => :sections
  
  SECTIONS = ['lessons', 'homework', 'materials', 'quizzes']
end
