class Lesson < ActiveRecord::Base
  belongs_to :notebooks
   
  has_many :shares, :dependent => :destroy
  
  has_many :contents, :dependent => :destroy
  
  accepts_nested_attributes_for :shares, :reject_if => lambda { |a| a[:shared_token].blank? }
  
  #accepts_nested_attributes_for :contents, :allow_destroy => true, :reject_if => lambda { |a| a[:content].blank? }
  
  validates :title, :presence => true
  validates :notebook_id, :presence => true
  validates :user_id, :presence => true
  
  def to_param
    "#{id}-#{title.parameterize}"
  end

end
