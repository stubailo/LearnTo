class Post < ActiveRecord::Base
  acts_as_taggable_on :tags
  
  
  belongs_to :user
  belongs_to :forum
  has_many :comments, :dependent => :destroy
  #has_many :tags
  #has_and_belongs_to_many :tags
  
  validates :title, :presence => true
  validates :content, :presence => true
end
