class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  validates :body, presence:{message:"there is no entry in the body"}
  def comment_time
    created_at.strftime("%B,%d, %Y at %l:%M %p")
  end
end
