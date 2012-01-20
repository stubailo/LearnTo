class Comment < ActiveRecord::Base
  belongs_to :post
  has_many :ratings, :dependent => :destroy
  has_many :subcomments, :dependent => :destroy
  validates :post_id, :presence => true
  validates :user_id, :presence => true
  validates :content, :presence => true
  
  def rating
    return self.ratings.sum(:value)
  end
end
