class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password
      t.string :clerk_id
      t.string :picture
      t.string :location
      t.string :country
      t.string :bio
      t.string :city
      t.string :youtube_link
      t.string :linkedin_link
      t.string :facebook_link
      t.string :instagram_link
      t.string :github_link
      t.string :x_link
      t.string :creation_type
      t.integer :reputation, default: 0
      t.integer :answers_count, default: 0
      t.integer :questions_count, default: 0
      t.integer :comments_count, default: 0
      t.boolean :published, default: true

      t.timestamps
    end
  end
end
