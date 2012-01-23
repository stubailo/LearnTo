class User < ActiveRecord::Base
  has_many :user_permissions
  has_many :class_rooms, :through => :user_permissions
  
  has_many :announcements
  has_many :posts
  
  has_many :post_ratings
  has_many :class_room_ratings
  
  
  def activate!
    self.active = true
    save(:validate => false)
  end
  
  def deliver_activation_instructions!
    reset_perishable_token!
    Notifier.activation_instructions(self).deliver
  end
  
  def deliver_welcome!
    reset_perishable_token!
    Notifier.welcome(self).deliver
  end

  acts_as_authentic do |c| c.login_field = :email end
  validates :login,  :presence => true
  validates :email, :presence => true
  validates :password, :presence => true,
                    :length => { :minimum => 5 }
  
end

