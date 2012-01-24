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
    @result = []
    @ids = []
    tokenize = search.scan(/"[^"]*"|[^"'\s]+/)
    tokenize = tokenize.map {|x| '%' + x.strip.gsub(/"/, '') + '%'}
    tokenize.each do |x|
      if @ids.size != 0
        temp =  Post.where("forum_id = ?", forum_id)
        .where('lower(title) LIKE ? OR lower(content) LIKE ?', x, x)
        .where('id NOT IN (?)', @ids)
        temp.each do |x|
          @ids.push(x.id)
        end
        @result += temp
      else
        temp =  Post.where("forum_id = ?", forum_id)
        .where('lower(title) Like ? OR lower(content) LIKE ?', x, x)
        temp.each do |x|
          @ids.push(x.id)
        end
        @result += temp
      end
    end
    return @result
  end
  
  def since_datetime(datetime, user_id)
    ids = []
    current_user.class_rooms.each do |x|
      ids.push(x.id)
    end
    t = Datetime.parse(datetime)
    return Post.where("created_at > ?", t).where("forum_id IN ?", ids)
  end
  
end
