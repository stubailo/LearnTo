class Section < ActiveRecord::Base
  validates_numericality_of :order
  validates :order, :presence => true
  validates :title, :presence => true

  belongs_to :resource_page
  has_many :resources, :dependent => :destroy
end
