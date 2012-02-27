class AddFileToCourselesson < ActiveRecord::Migration
  def change
    add_column :course_lessons, :file, :string
  end
end
