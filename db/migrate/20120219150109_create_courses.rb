class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.integer :user_id
      t.string :name
      t.string :number
      t.string :department
      t.string :term
      t.string :school

      t.timestamps
    end
    add_index :courses, :user_id
  end
end
