class User < ActiveRecord::Base
  acts_as_authentic do |c| c.login_field = :email end
  validates :login,  :presence => true
  validates :email, :presence => true
  validates :password, :presence => true,
                    :length => { :minimum => 5 }
end

