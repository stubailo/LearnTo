class Tag < ActiveRecord::Base
  belongs_to :post
  #has_and_belongs_to_many :posts
end
