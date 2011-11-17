class Share < ActiveRecord::Base
  attr_accessible :shared_token, :shared_ids
  belongs_to :lesson
  
  attr_reader :shared_token
  serialize :shared_ids
  
  def shared_token=(ids)
    self.shared_ids = ids.split(",")
  end
end
