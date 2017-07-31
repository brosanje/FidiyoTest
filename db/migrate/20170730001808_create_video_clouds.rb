class CreateVideoClouds < ActiveRecord::Migration[5.1]
  def change
    create_table :video_clouds do |t|
      t.string :backing_store
      t.string :description
      t.string :access

      t.timestamps
    end

    add_index :video_clouds, "lower(description) varchar_pattern_ops"
  end
end
