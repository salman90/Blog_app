class User < ActiveRecord::Base
#i am adding a comment

  has_secure_password #adds the passowrd and the passowrd confi
  has_many :comments, dependent: :nullify
  has_many :posts, dependent: :nullify  # one to meny

  has_many :favourites, dependent: :destroy
  has_many :favourite_posts, through: :favourites, source: :post #meny to meny

validates :first_name , presence: true
validates :last_name , presence: true
validates :email , presence: true,
                  uniqueness: true ,
                  format:  /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

end
