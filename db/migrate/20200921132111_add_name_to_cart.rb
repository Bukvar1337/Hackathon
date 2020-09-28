class AddNameToCart < ActiveRecord::Migration[6.0]
  def change
    add_column :carts, :name, :string
  end
end
