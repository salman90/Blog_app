# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if Category.count == 0
  ["comment","title"].each do |c|
    Category.create(title: c)
  end
end

30.times { Tag.create(title: Faker::Name.name) }
