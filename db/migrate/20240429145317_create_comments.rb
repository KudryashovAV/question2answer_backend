class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.string :content
      t.references :user, null: false, foreign_key: true
      t.string :commented_to_type
      t.integer :commented_to_id
      t.string :creation_type
      t.boolean :published, default: true

      t.timestamps
    end
  end
end
