FactoryGirl.define do
  factory :favourite do
    user { create(:user) }
    post {create(:post)}
  end
end
