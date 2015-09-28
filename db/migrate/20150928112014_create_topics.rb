class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :name
      t.text :article
      t.string :state
      t.integer :view
      t.timestamps null: false
    end
  end
end
