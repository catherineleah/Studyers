class Lesson < ActiveRecord::Base
  belongs_to :notebooks
  
  validates :title, :presence => true
  validates :notebook_id, :presence => true
  validates :user_id, :presence => true
  
  
  #### Attach canvas as png
  include Datafy
  
  attr_accessor :attachment64

  before_validation :save_attachment64

  has_attached_file :attachement, 
    :storage => :s3,
    :bucket => 'israel-hosting.net',
    :s3_credentials => "#{RAILS_ROOT}/config/s3.yml"
  
  # send id & title as url param
  def to_param
    "#{id}-#{title.parameterize}"
  end
                           
                             
  private
    def save_attachment64
      if attachment64.present?
        File.open("tmp/lesson.png", "wb") { |f| f.write(Datafy::decode_data_uri(attachment64)[0]) }  
        self.attachement = File.open("tmp/lesson.png", "r")
      end
    end
end
