class Subcomment < ActiveRecord::Base
  belongs_to :user
  belongs_to :comment
  validates :user_id, :presence => true
  validates :comment_id, :presence => true
  validates :content, :presence => true
  
  has_many :notifications, :as => :item, :dependent => :destroy
  
end
