class User < ActiveRecord::Base
  has_many :user_permissions
  has_many :class_rooms, :through => :user_permissions

  acts_as_authentic do |c| c.login_field = :email end
  validates :login,  :presence => true
  validates :email, :presence => true
  validates :password, :presence => true,
                    :length => { :minimum => 5 }
  has_many :posts
end

