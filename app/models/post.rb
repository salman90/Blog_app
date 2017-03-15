class Post < ActiveRecord::Base
  mount_uploader :image, ImgeUploader



  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  has_many :favourites, dependent: :destroy
  has_many :users, through: :favourites

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

  def favourited_by?(user)
    favourites.exists?(user: user)
  end

  def favourite_for(user)
    favourites.find_by_user_id user
  end
  def post_time
    created_at.strftime("%B at %l:%M %p")
  end
end
