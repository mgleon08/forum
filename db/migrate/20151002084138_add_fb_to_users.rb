class AddFbToUsers < ActiveRecord::Migration
  def change
    add_column :users, :fb_token, :string
    add_column :users, :fb_raw_data, :string
  end
end
