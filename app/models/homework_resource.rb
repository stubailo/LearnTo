class HomeworkResource < ActiveRecord::Base
  belongs_to :homework
  belongs_to :resource
end
