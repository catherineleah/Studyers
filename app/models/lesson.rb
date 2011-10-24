class Lesson < ActiveRecord::Base
  belongs_to :notebooks
  has_many :shares, :dependent => :destroy
  accepts_nested_attributes_for :shares, :reject_if => lambda { |a| a[:shared_ids].blank? }
  
  validates :title, :presence => true
  validates :notebook_id, :presence => true
  validates :user_id, :presence => true
  
  def to_param
    "#{id}-#{title.parameterize}"
  end

end
