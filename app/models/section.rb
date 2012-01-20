class Section < ActiveRecord::Base
  belongs_to :resource_page
  has_many :resources, :dependent => :destroy
end
