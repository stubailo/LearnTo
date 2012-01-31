class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :forum
  has_many :comments, :dependent => :destroy
  
  validates :title, :presence => true
  validates :content, :presence => true
  
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
