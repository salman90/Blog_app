class Post < ActiveRecord::Base
  validates :title, presence: {message:"the title have no title"},
                    uniqueness: true

end
