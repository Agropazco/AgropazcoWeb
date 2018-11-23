class PostScore < ApplicationRecord
	belongs_to :post, class_name: "Post"
	belongs_to :scoring_user,
			class_name: "User",
			foreign_key: "scoring_user_id"

	validates :post_id, presence: true
	validates :scoring_user_id, presence: true
	validates :score, presence: true
end
