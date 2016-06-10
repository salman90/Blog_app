class Comment < ActiveRecord::Base
  validates :body, presence:{message:"there is no entry in the body"},
                  uniqueness: true
end
