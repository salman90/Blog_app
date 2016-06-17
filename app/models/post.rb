class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  belongs_to :category
  belongs_to :user
  validates :title, presence: {message:"the title have no title"},
                    uniqueness: true

    validates :body, presence: {message: "there is no body"}

  def body_snippet
    if self.body.length > 100
      self.body[1..100] + "..."
    end
  end
end
