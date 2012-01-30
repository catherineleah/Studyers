class AddUserIdToClassResources < ActiveRecord::Migration
  def change
    add_column :class_resources, :user_id, :integer
  end
end
