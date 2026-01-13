class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  has_many :posts, dependent: :destroy

  # Callbacks
  before_create :randomize_id

  has_many :comments

  has_many :likes

  # Followers
  has_many :follows_as_follower, class_name: "Follow", foreign_key: :follower_id
  has_many :following, through: :follows_as_follower, source: :followed

  # Followed by
  has_many :follows_as_followed, class_name: "Follow", foreign_key: :followed_id
  has_many :followers, through: :follows_as_followed, source: :follower

validates :username, presence: true, uniqueness: true
  validates :bio, length: { maximum: 150 }
  private

  def randomize_id
    begin
      self.id = SecureRandom.random_number(1_000_000_000)
    end while User.where(id: self.id).exists?
  end
end
