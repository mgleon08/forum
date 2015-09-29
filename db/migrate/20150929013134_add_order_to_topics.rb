class AddOrderToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :most_comment, :integer
    add_column :topics, :last_comment, :datetime
  end
end
