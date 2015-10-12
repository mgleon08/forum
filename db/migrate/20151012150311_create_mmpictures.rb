class CreateMmpictures < ActiveRecord::Migration
  def change
    create_table :mmpictures do |t|
      t.string :title
      t.attachment :upload
      t.integer :topic_id, index: true
      t.timestamps null: false
      t.timestamps null: false
    end
  end
end
