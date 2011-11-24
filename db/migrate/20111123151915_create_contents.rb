class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.integer :lesson_id
      t.string :type
      t.text :content

      t.timestamps
    end
  end
end
