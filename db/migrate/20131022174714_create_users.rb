class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email, :null => false
      t.date :birthdate
      t.string :password_digest, :null => false
      t.timestamps
    end
    add_index :users, :email, :unique => true
  end
end
