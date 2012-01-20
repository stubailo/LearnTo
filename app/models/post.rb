class Post < ActiveRecord::Base
  acts_as_taggable_on :tags
  
  belongs_to :user
  belongs_to :forum
  has_many :comments, :dependent => :destroy
  #has_many :tags
  #has_and_belongs_to_many :tags
  
  validates :title, :presence => true
  validates :content, :presence => true
  
  def self.search_by_tag(tag, forum_id)
    Post.tagged_with(tag).where("forum_id = ?", forum_id)
  end
  
  def self.search(search, forum_id)
    search_condition = "%" + search + "%"
    Post.where("forum_id = ?", forum_id)
    .where('lower(title) LIKE ? OR lower(content) LIKE ?', search_condition.downcase, search_condition.downcase)
  end
end
