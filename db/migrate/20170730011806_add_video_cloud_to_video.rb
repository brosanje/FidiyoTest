class AddVideoCloudToVideo < ActiveRecord::Migration[5.1]
  def change
    add_reference :videos, :video_cloud, foreign_key: true
  end
end
