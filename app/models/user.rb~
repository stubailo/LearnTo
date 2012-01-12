class User < ActiveRecord::Base
  acts_as_authentic
  validates :login,  :presence => true
  validates :email, :presence => true
  validates :password, :presence => true,
                    :length => { :minimum => 5 }
end

