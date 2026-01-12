# app/models/comment.rb
class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validates :text, presence: true
  validates :user, presence: true
  validates :post, presence: true
end
