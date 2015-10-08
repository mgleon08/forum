class ScheduledToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :scheduled, :datetime
  end
end
