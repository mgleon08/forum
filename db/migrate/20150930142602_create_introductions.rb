class CreateIntroductions < ActiveRecord::Migration
  def change
    create_table :introductions do |t|
      t.text :pro
      t.integer :user_id
      t.timestamps null: false
    end
  add_index :introductions, :user_id
  end
end
