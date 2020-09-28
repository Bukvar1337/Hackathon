class AddVotesCountToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :votesCount, :integer, default: 0
  end
end
