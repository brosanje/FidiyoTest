class Video < ApplicationRecord
  belongs_to :user
  belongs_to :video_cloud
  belongs_to :video_category
  has_many :video_distributions
end
