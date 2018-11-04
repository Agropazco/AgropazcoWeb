class Message
	include ActiveModel::Model
	attr_accessor :name, :email, :subject, :body
	validates :name, :email, :subject, :body, presence: true
end
