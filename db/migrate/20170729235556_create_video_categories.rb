class CreateVideoCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :video_categories do |t|
      t.string :category
      t.string :description

      t.timestamps
    end

    add_index :video_categories, :category, unique: true
    add_index :video_categories, "lower(description) varchar_pattern_ops"
  end
end
