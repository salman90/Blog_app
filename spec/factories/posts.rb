FactoryGirl.define do
  factory :post do
    title {Faker::Superhero.name}
    body {Faker::Lorem.paragraph}
  end
end
