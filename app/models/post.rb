# title and description will come from Migration (Columns on the table)
class Post < ApplicationRecord
  validates :title, presence: true, length: { minimum: 5, maximum: 50 }

  validates :description, presence: true, length: { minimum: 5, maximum: 500 }

  validates :keywords, presence: true, length: { minimum: 5, maximum: 20 }

  has_many_attached :images

  belongs_to :user

  has_many :comments

  has_many :likes

  # Callbacks
  before_create :randomize_id

  private

  def randomize_id
    begin
      self.id = SecureRandom.random_number(1_000_000_000)
    end while Post.where(id: self.id).exists?
  end
end
