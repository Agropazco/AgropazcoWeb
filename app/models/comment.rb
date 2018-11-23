class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  validates :post_id, presence: true
  validates :user_id, presence: true
  validates :body,
    presence: true,
    length: {maximum: 1000}
  default_scope -> {order(created_at: :desc)}

  def time_as_string
    created_at.strftime("%m/%d/%y a las %l:%M %p")
  end
 end
 
