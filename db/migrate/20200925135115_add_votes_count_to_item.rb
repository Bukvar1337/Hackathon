class AddVotesCountToItem < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :votesCount, :integer, default: 0
  end
end
