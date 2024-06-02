class CreateAnswers < ActiveRecord::Migration[7.1]
  def change
    create_table :answers do |t|
      t.string :content
      t.references :user, null: false, foreign_key: true
      t.references :last_user_commented, foreign_key: { to_table: :users }
      t.references :question, null: false, foreign_key: true
      t.integer :comments_count, default: 0
      t.string :creation_type
      t.string :last_user_commented_type
      t.boolean :published, default: true
      t.boolean :reserved, default: true

      t.timestamps
    end
  end
end
