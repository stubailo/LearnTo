class Document < ActiveRecord::Base
  belongs_to :resource
  has_many :resources, :dependent => :destroy
end
