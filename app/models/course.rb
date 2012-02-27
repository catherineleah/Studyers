class Course < ActiveRecord::Base
  belongs_to :user
  has_many :course_lessons, :dependent => :destroy
end
