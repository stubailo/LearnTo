class ResourceComment < ActiveRecord::Base
  belongs_to :resource
  belongs_to :user
  validates :resource_id, :presence => true
  validates :user_id, :presence => true
  validates :content, :presence => true
  has_many :notifications, :as => :item, :dependent => :destroy
end
