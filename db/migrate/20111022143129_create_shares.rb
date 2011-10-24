class CreateShares < ActiveRecord::Migration
  def change
    create_table :shares do |t|
      t.integer :lesson_id
      t.string :shared_ids

      t.timestamps
    end
  end
end
