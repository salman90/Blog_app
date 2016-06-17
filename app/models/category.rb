class Category < ActiveRecord::Base
  validates :title, presence:{message: "has no input"}
  has_many :posts

end
