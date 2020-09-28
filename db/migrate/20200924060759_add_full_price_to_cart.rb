class AddFullPriceToCart < ActiveRecord::Migration[6.0]
  def change
    add_column :carts, :fullPrice, :integer
  end
end
