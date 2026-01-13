class AddDescriptionToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :bio, :string
    add_column :users, :username, :string
  end
end
