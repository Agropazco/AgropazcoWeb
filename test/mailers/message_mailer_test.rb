require 'test_helper'

class MessageMailerTest < ActionMailer::TestCase
  test "contact" do
    message = EmailMessage.new name: 'anna',
                          email: 'anna@example.org',
                          subject: 'tematica',
                          body: 'hello, how are you doing?'

    email = MessageMailer.contact(message)

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal ['cdsanabriar@unal.edu.co'], email.to
    assert_equal ['anna@example.org'], email.from
    assert_match /hello, how are you doing?/, email.body.encoded
  end
end
