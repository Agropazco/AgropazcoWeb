# Preview all emails at http://localhost:3000/rails/mailers/message_mailer
class MessageMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/message_mailer/contact
  def contact
  	message = Message.new name: 'marflar', 
                          email: 'marflar@example.org',
                          subject: 'temita',
                          body: 'This is the body of the email'
    MessageMailer.contact
  end

end
