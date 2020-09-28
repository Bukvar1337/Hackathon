class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string  :name
      t.text    :description
      t.integer :weight
      t.integer :price
      t.integer :user_id
      t.timestamps
    end
  end
end
