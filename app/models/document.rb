class Document < ActiveRecord::Base
  belongs_to :resource
  has_many :resources
end
