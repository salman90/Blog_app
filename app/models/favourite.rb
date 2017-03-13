class Favourite < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  validates :user_id, uniqueness: {scope: :post_id}
  # validates_uniqueness_of :user_id, scope: :post_id
  validates :user_id, presence: true
  validates :post_id, presence: true
end
