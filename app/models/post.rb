class Post < ApplicationRecord

  belongs_to :user
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 100 }
  validates :content, presence: true, length: { maximum: 10000 }
  has_many :post_scores
  has_many :post_reports
  
end
