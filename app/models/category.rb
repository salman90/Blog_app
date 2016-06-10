class Category < ActiveRecord::Base
  validates :title, presence:{message: "has no input"}
end
