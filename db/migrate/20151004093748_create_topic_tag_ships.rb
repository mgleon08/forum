class CreateTopicTagShips < ActiveRecord::Migration
  def change
    create_table :topic_tag_ships do |t|
      t.integer :topic_id
      t.integer :tag_id
      t.timestamps null: false
    end
    add_index :topic_tag_ships, :topic_id
    add_index :topic_tag_ships, :tag_id
  end
end
