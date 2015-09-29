class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :name
      t.text :article
      t.string :state
      t.integer :view, default: 0
      t.integer :user_id
      t.timestamps null: false
    end
    add_index :topics, :user_id
  end
end
