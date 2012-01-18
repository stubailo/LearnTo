class ClassRoom < ActiveRecord::Base  
  validates :name,  :presence => true
  validates :occupancy, :presence => true
  validates :price, :presence => true
  validates_numericality_of :price
  validates_numericality_of :occupancy
  
  has_many :user_permissions
  has_many :users, :through => :user_permissions
  
  has_many :homeworks
  has_many :homework_sections, :through => :homeworks

  has_one :forum, :dependent => :destroy
end
