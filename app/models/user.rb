class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships, -> { where status: false }
  has_many :friends, -> { where status: true }, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'

  def self.check_request(current_user, friend_id)
    current_user.friendships.exists?(friend_id: friend_id)
  end
end
