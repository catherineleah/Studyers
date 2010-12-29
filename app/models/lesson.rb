class Lesson < ActiveRecord::Base
  belongs_to :notebooks
  
  validates :title, :presence => true
  validates :notebook_id, :presence => true
  validates :user_id, :presence => true
end
