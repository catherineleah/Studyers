class CourseLesson < ActiveRecord::Base
  belongs_to :course
  
  has_many :videos, :dependent => :destroy
  accepts_nested_attributes_for :videos, :reject_if => lambda { |a| a[:link].blank? }, :allow_destroy => true
  
  validates :name, :presence => true
  validates :course_id, :presence => true
  validates :user_id, :presence => true
  
  mount_uploader :file, PresentationUploader
  
end
