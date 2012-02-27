class AddUserIdToCourseLessons < ActiveRecord::Migration
  def change
    add_column :course_lessons, :user_id, :integer
  end
end
