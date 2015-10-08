class AddCompetenceToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :competence, :string
  end
end
