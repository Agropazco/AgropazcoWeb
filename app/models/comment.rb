class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  validates :post_id, presence: true
  validates :user_id, presence: true
  validates :body,
    presence: true,
    length: {maximum: 1000}

  def message_time
    created_at.strftime("%m/%d/%y a las %l:%M %p")
  end
 end
 
