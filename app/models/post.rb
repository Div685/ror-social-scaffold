class Post < ApplicationRecord
  validates :content, presence: true, length: { maximum: 1000,
                                                too_long: '1000 characters in post is the maximum allowed.' }

  belongs_to :user

  scope :ordered_by_most_recent, -> { order(created_at: :desc) }
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  def self.friends_and_own_posts(user)
    friends_posts = user.friends.pluck(:user_id)
    friends_posts << user.id

    Post.where(user_id: friends_posts).order('posts.updated_at DESC')
  end
end
