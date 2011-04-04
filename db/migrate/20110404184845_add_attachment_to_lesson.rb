class AddAttachmentToLesson < ActiveRecord::Migration
  def self.up
    add_column :lessons, :attachement_file_name,    :string
    add_column :lessons, :attachement_content_type, :string
    add_column :lessons, :attachement_file_size,    :integer
    add_column :lessons, :attachement_updated_at,   :datetime
  end

  def self.down
    remove_column :lessons, :attachement_file_name
    remove_column :lessons, :attachement_content_type
    remove_column :lessons, :attachement_file_size
    remove_column :lessons, :attachement_updated_at
  end
end
