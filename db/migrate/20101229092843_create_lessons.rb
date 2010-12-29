class CreateLessons < ActiveRecord::Migration
  def self.up
    create_table :lessons do |t|
      t.string :title
      t.text :body
      t.integer :notebook_id
      t.integer :user_id
      t.integer :permission

      t.timestamps
    end
  end

  def self.down
    drop_table :lessons
  end
end
