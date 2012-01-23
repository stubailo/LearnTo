class Comment < ActiveRecord::Base
  belongs_to :post
  has_many :post_ratings, :dependent => :destroy
  has_many :subcomments, :dependent => :destroy
  validates :post_id, :presence => true
  validates :user_id, :presence => true
  validates :content, :presence => true
  
  def rating
    return self.post_ratings.sum(:value)
  end
  
  def rating_by_user(user_id)
    a = PostRating.where("user_id = ? AND comment_id = ?", user_id, self.id).first
    if a
      return a.value
    else
      return 0
    end
  end
  
  
end
