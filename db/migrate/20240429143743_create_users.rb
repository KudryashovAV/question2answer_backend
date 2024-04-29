class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :clerk_id
      t.string :name
      t.string :user_name
      t.string :email
      t.string :password
      t.string :bio
      t.string :picture
      t.string :location
      t.string :portfolio
      t.integer :reputation, default: 0

      t.timestamps
    end
  end
end
