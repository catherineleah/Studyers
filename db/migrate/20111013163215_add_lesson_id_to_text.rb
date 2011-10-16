class AddLessonIdToText < ActiveRecord::Migration
  def change
    add_column :texts, :lesson_id, :integer
    add_column :images, :lesson_id, :integer
    add_column :presentations, :lesson_id, :integer
  end
end
