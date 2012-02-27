class CourseLesson < ActiveRecord::Base
  belongs_to :course
  
  validates :name, :presence => true
  validates :course_id, :presence => true
  validates :user_id, :presence => true
  
  #has_many :lessonfiles, :dependent => :destroy
  #accepts_nested_attributes_for :lessonfiles, :reject_if => lambda { |a| a[:file].blank? }, :allow_destroy => true
  
  mount_uploader :file, PresentationUploader
  
end
