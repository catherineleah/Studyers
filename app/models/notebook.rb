class Notebook < ActiveRecord::Base
  validates :name, :presence => true
  belongs_to :user
  has_many :lessons, :dependent => :destroy
  
  # send id & title as url param
  def to_param
    "#{id}-#{name.parameterize}"
  end
  
end
