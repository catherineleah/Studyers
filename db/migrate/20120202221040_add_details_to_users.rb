class AddDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :study_at, :string
    add_column :users, :major, :string
    add_column :users, :minor, :string
    add_column :users, :language, :string
  end
end
