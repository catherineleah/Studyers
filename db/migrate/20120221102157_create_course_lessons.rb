class CreateCourseLessons < ActiveRecord::Migration
  def change
    create_table :course_lessons do |t|
      t.references :course
      t.string :name

      t.timestamps
    end
    add_index :course_lessons, :course_id
  end
end
