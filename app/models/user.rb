class User < ActiveRecord::Base
  has_and_belongs_to_many :class_rooms

  acts_as_authentic do |c| c.login_field = :email end
  validates :login,  :presence => true
  validates :email, :presence => true
  validates :password, :presence => true,
                    :length => { :minimum => 5 }
  has_many :posts
end

