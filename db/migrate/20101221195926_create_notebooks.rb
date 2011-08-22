class CreateNotebooks < ActiveRecord::Migration
  def self.up
    create_table :notebooks do |t|
      t.string :name
      t.integer :user_id

      t.timestamps
    end
    add_index :notebooks, :user_id
  end

  def self.down
    drop_table :notebooks
  end
end
