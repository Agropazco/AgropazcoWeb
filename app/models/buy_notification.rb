class BuyNotificationValidator < ActiveModel::Validator
	def validate(record)
		return unless record.errors.blank?
		if (record.post.nil?)
			record.errors[:base] << "Post invalido"
		elsif record.seller.nil? || record.buyer.nil?
			record.errors[:base] << "Comprador o Vendedor incorrecto"
		elsif record.seller_id == record.buyer_id
			record.errors[:base] << "Un usuario no puede comprar su propio post"
		end
	end
end


class BuyNotification < ApplicationRecord


	validates :message, :post_id, :seller_id, :buyer_id, presence: true
	validates_with BuyNotificationValidator
	belongs_to :buyer, :class_name => 'User'
  belongs_to :seller, :class_name => 'User'
	belongs_to :post

	def post
		Post.find_by(id: post_id)
	end

	def seller
		User.find_by(id: seller_id)
	end

	def buyer
		User.find_by(id: buyer_id)
	end

end
