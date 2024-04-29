class CreateQuestions < ActiveRecord::Migration[7.1]
  def change
    create_table :questions do |t|
      t.string :title
      t.string :content
      t.references :user, null: false, foreign_key: true
      t.integer :views, default: 0

      t.timestamps
    end
  end
end
