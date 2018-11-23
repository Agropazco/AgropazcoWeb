class PostReportValidator < ActiveModel::Validator
	def validate(record)
		return unless record.errors.blank?
		if record.post.nil?
			record.errors[:base] << "Post inválido"
		elsif record.user.nil?
			record.errors[:base] << "Usuario inválido"
		elsif record.post.user_id==record.user_id
			record.errors[:base] << "Un usuario no puede reportar su propio post"
		end
	end
end

class PostReport < ApplicationRecord
	validates :message, :topic, :post_id, :user_id, presence: true
	validates_with PostReportValidator
	belongs_to :user
	belongs_to :post

	def post
		Post.find_by(id: post_id)
	end

	def user
		User.find_by(id: user_id)
	end
end
