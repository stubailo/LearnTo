class ClassRoom < ActiveRecord::Base  
  validates :name,  :presence => true
  #validates :occupancy, :presence => true
  #validates :price, :presence => true
  #validates_numericality_of :price
  #validates_numericality_of :occupancy
  validates :start_date, :presence => true
  #validates :end_date, :presence => true
  validates :tag_line, :length => { :maximum => 150 }
  
  has_many :user_permissions
  has_many :users, :through => :user_permissions
  
  has_many :resource_pages, :dependent => :destroy
  has_many :sections, :through => :resource_pages
  has_many :resources
  
  has_many :announcements, :dependent => :destroy
  
  has_many :class_room_ratings
  
  has_one :forum, :dependent => :destroy

  belongs_to :resource, :foreign_key => "description_id"

  belongs_to :user
  
  # never change these names, or the order, ever :D
  CATEGORIES = [ 'All', 'Humanities', 'Science/Engineering', 'Life Skills', 'Other' ]  
  
  
  def rating
    return self.class_room_ratings.sum(:value)
  end
  
  def rating_by_user(user_id)
    a = ClassRoomRating.where("user_id = ? AND class_room_id = ?", user_id, self.id).first
    if a
      return a.value
    else
      return 0
    end
  end
  
  def self.search(search, category)
    @result = []
    @ids = []
    if search == nil && category == nil
      return @result
    elsif(category == nil && search == "")
      return ClassRoom.all
    elsif search == "" || search == nil
      return ClassRoom.where('category = ?', category)
    else
			tokenize = search.scan(/"[^"]*"|[^"'\s]+/)
			tokenize = tokenize.map {|x| '%' + x.strip.gsub(/"/, '') + '%'}
			tokenize.each do |x|
				if @ids.size != 0
					temp =  category ? ClassRoom.where('lower(name) LIKE ? OR lower(tag_line) LIKE ? OR lower(summary) LIKE ?', x.downcase, x.downcase, x.downcase)
					.where('id NOT IN (?)', @ids).where('category = ?', category)
					:
					ClassRoom.where('lower(name) LIKE ? OR lower(tag_line) LIKE ? OR lower(summary) LIKE ?', x.downcase, x.downcase, x.downcase)
					.where('id NOT IN (?)', @ids)
					temp.each do |x|
						@ids.push(x.id)
					end
					@result += temp
				else
					temp = category ? ClassRoom.where('lower(name) Like ? OR lower(tag_line) LIKE ? OR lower(summary) LIKE ?', x.downcase, x.downcase, x.downcase)
					.where('category = ?', category)
					:
					ClassRoom.where('lower(name) Like ? OR lower(tag_line) LIKE ? OR lower(summary) LIKE ?', x.downcase, x.downcase, x.downcase)
					temp.each do |x|
						@ids.push(x.id)
					end
					@result += temp
				end
			end
			return @result
		end
  end
  
end

