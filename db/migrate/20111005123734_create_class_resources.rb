class CreateClassResources < ActiveRecord::Migration
  def change
    create_table :class_resources do |t|
      t.string :title
      t.string :presentation

      t.timestamps
    end
  end
end
