class CreateMpictures < ActiveRecord::Migration
  def change
    create_table :mpictures do |t|
      t.string :title
      t.attachment :upload
      t.integer :topic_id, index: true
      t.timestamps null: false
    end
  end
end
