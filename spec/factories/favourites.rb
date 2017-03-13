FactoryGirl.define do
  factory :favourite do
    user { create(:conversation) }
    post {create(:post)}
  end
end
