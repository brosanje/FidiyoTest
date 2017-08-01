class CreateVideos < ActiveRecord::Migration[5.1]
  def change
    create_table :videos do |t|
      t.string :resource_path
      t.boolean :isSelect
      t.string :color
      t.string :description
      t.references :users, foreign_key: true
      ##t.references :video_categories, foreign_key: true
      ##t.references :video_clouds, foreign_key: true

      t.timestamps
    end

    add_index :videos, :resource_path ## , unique: true
    add_index :videos, "lower(description) varchar_pattern_ops"
  end
end
