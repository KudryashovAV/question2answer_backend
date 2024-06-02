class FeatureFlags < ActiveRecord::Migration[7.1]
  def change
    create_table :feature_flags do |t|
      t.string :name, null: false
      t.boolean :enabled, default: true
    end
  end
end
