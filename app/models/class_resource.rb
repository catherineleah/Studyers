class ClassResource < ActiveRecord::Base
  mount_uploader :presentation, PresentationUploader
end
