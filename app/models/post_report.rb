class PostReportValidator < ActiveModel::Validator
	def validate(record)
		if record.errors.blank? and record.post.user_id==record.user_id
			record.errors[:base] << "Un usuario no puede reportar su propio post"
		end
	end
end

class PostReport < ApplicationRecord
	validates :message, :topic, :post_id, :user_id, presence: true
	validates_with PostReportValidator
	def post
		Post.find(post_id)
	end
end
