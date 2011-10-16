class CreatePresentations < ActiveRecord::Migration
  def change
    create_table :presentations do |t|
      t.text :slide

      t.timestamps
    end
  end
end
