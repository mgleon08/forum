class CreateTopicUserCollects < ActiveRecord::Migration
  def change
    create_table :topic_user_collects do |t|
      t.integer :user_id
      t.integer :topic_id
      t.timestamps null: false
    end
    add_index :topic_user_collects, :user_id
    add_index :topic_user_collects, :topic_id
  end
end
