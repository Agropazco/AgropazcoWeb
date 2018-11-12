class PostScore < ApplicationRecord
	belongs_to :post, class_name: "Post"
	validates :post_id, presence: true
	validates :scoring_user_id, presence: true
	validates :score, presence: true
end
