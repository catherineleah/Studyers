class Lesson < ActiveRecord::Base
  belongs_to :notebooks
  
  validates :title, :presence => true
  validates :notebook_id, :presence => true
  validates :user_id, :presence => true
  
  
  ####
  include Datafy
  
  attr_accessor :attachment64

  before_validation :save_attachment64

  has_attached_file :attachement, :styles => { :normal => ['200x200>'], :stack => ['137x133>'] }
                               
  private
    def save_attachment64
      File.open("tmp/reply.png", "wb") { |f| f.write(Datafy::decode_data_uri(attachment64)[0]) }  
      self.attachement = File.open("tmp/reply.png", "r")
    end
end
