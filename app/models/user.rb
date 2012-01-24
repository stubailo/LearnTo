class User < ActiveRecord::Base
  acts_as_authentic do |c| c.login_field = :email end
  validates :login,  :presence => true
  validates :email, :presence => true
  validates :password, :presence => true,
                    :length => { :minimum => 5 }

  has_many :user_permissions
  has_many :class_rooms, :through => :user_permissions
  has_many :taught_classes, :as => :class_rooms
  
  has_many :announcements
  has_many :posts
  
  has_many :post_ratings
  has_many :class_room_ratings
  
  has_many :authentications
  
  ACCOUNT_TYPES = ["internal", "both", "external"]
  
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
  
  def self.create_from_hash(auth_hash)
    puts hash.to_yaml
    user = User.new(:login => auth_hash['info']['name'], :email => auth_hash['info']['email'], :crypted_password => "000", 
    :password_salt => "000", :active => true, :account_type => "external" )
    user.save(:validations => false) #create the user without performing validations. This is because most of the fields are not set.
    user.reset_persistence_token! #set persistence_token else sessions will not be created
    user
  end
  
end

