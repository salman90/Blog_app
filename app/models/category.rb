class Category < ActiveRecord::Base
  validates :title, presence:{message: "has no input"} , uniqueness: true 
  has_many :posts

end
