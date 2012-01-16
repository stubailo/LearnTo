class Comment < ActiveRecord::Base
  belongs_to :post
  has_many :ratings
  validates :post_id, :presence => true
  validates :user_id, :presence => true
  
  def rating(current_user_id)
    return Rating.where("user_id = ? AND comment_id = ?", current_user_id, id).sum(:value)
  end
end
