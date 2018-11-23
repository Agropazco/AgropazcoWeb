class Post < ApplicationRecord

  belongs_to :user
  default_scope -> {order(created_at: :desc)}
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 100 }
  validates :content, presence: true, length: { maximum: 10000 }
  validate :picture_size
  has_many :post_scores, dependent: :destroy
  has_many :post_reports, dependent: :destroy
  
  private 
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture , "Debe pesar menos de 5MB")
      end
    end
  
end
