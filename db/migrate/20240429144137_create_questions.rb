class CreateQuestions < ActiveRecord::Migration[7.1]
  def change
    create_table :questions do |t|
      t.string :title
      t.string :content
      t.references :user, null: false, foreign_key: true
      t.references :last_user_commented, foreign_key: { to_table: :users }
      t.references :last_user_answered, foreign_key: { to_table: :users }
      t.integer :views, default: 0
      t.integer :answers_count, default: 0
      t.integer :comments_count, default: 0
      t.string :creation_type
      t.string :slug
      t.string :last_user_commented_type
      t.string :last_user_answered_type
      t.boolean :published, default: true
      t.string :location, default: "EN"

      t.timestamps
    end

    add_index :questions, :slug, unique: true
  end
end
