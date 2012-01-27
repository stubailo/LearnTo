class Post < ActiveRecord::Base
  acts_as_taggable_on :tags
  
  has_many :notifications, :as => :item
  
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
    @result = []
    @ids = []
    tokenize = search.scan(/"[^"]*"|[^"'\s]+/)
    tokenize = tokenize.map {|x| '%' + x.strip.gsub(/"/, '') + '%'}
    tokenize.each do |x|
      if @ids.size != 0
        temp =  Post.where("forum_id = ?", forum_id)
        .where('lower(title) LIKE ? OR lower(content) LIKE ?', x.downcase, x.downcase)
        .where('id NOT IN (?)', @ids)
        temp.each do |y|
          @ids.push(y.id)
        end
        @result += temp
      else
        temp =  Post.where("forum_id = ?", forum_id)
        .where('lower(title) Like ? OR lower(content) LIKE ?', x.downcase, x.downcase)
        temp.each do |y|
          @ids.push(y.id)
        end
        @result += temp
      end
    end
    return @result
  end
  
end
