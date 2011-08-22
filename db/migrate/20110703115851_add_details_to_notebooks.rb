class AddDetailsToNotebooks < ActiveRecord::Migration
  def self.up
    add_column :notebooks, :course, :string
    add_column :notebooks, :lecturer, :string
  end

  def self.down
    remove_column :notebooks, :lecturer
    remove_column :notebooks, :course
  end
end
