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

validates :username, presence: true, uniqueness: true
  validates :bio, length: { maximum: 150 }
  private

  def randomize_id
    begin
      self.id = SecureRandom.random_number(1_000_000_000)
    end while User.where(id: self.id).exists?
  end
end
