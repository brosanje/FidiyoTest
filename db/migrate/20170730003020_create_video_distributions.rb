class CreateVideoDistributions < ActiveRecord::Migration[5.1]
  def change
    create_table :video_distributions do |t|
      t.datetime :distributed_at
      t.string :link_url
      t.boolean :require_login
      t.boolean :expired
      t.integer :view_count_limit
      t.string :description
      t.references :video, foreign_key: true

      t.timestamps
    end

    add_index :video_distributions, "lower(description) varchar_pattern_ops", :name => "index_video_distribution_description_pattern"
  end
end
