  class User < ActiveRecord::Base
  has_secure_password #adds the passowrd and the passowrd confi
  mount_uploader :picture, ImgeUploader
  has_many :comments, dependent: :nullify
  has_many :posts, dependent: :nullify  # one to meny

  has_many :favourites, dependent: :destroy
  has_many :favourite_posts, through: :favourites, source: :post #meny to meny

validates :first_name , presence: true
validates :last_name , presence: true
validates :email , presence: true,
                  uniqueness: true ,
                  format:  /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i


def full_name
  "#{first_name.capitalize}" + " " + "#{last_name.capitalize}"
end

end
