class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string  :email,              null: false, default: ""
      t.string  :password,           null: false, default: ""
      t.string  :login,              null: false, default: ""
      t.string  :firstName,          null: false, default: ""
      t.string  :secondName,         null: false, default: ""
      t.string  :sex,                null: false, default: ""
      t.string  :gitLink,            null: false, default: ""
      t.integer :age
      t.timestamps
    end
  end
end
