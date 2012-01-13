class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :forum
  has_many :comments
  has_and_belongs_to_many :tags
  
  validates :title, :presence => true
  validates :content, :presence => true
end
