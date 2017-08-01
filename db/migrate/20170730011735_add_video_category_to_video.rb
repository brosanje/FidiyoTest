class AddVideoCategoryToVideo < ActiveRecord::Migration[5.1]
  def change
    add_reference :videos, :video_category, foreign_key: true
  end
end
