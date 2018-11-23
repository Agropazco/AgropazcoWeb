class Post < ApplicationRecord

  belongs_to :user
  default_scope -> {order(created_at: :desc)}
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 100 }
  validates :content, presence: true, length: { maximum: 10000 }
  validate :picture_size
  validate :is_vendor
  has_many :post_scores, dependent: :destroy
  has_many :post_reports, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  private 
    def picture_size
      if picture.size > 5.megabytes
        puts "size"
        errors.add(:picture , "Debe pesar menos de 5MB")
      end
    end
    def is_vendor 
      if !user.vendor?
        puts user.role 
        errors.add(:user, "Debe ser vendedor para publicar")
      end
    end
  
end
