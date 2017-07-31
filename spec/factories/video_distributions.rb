FactoryGirl.define do
  factory :video_distribution do
    distributed_at "2017-07-29 20:30:20"
    link_url "MyString"
    require_login false
    expired false
    view_count_limit 1
    video nil
  end
end
