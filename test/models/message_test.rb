require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  test 'responds to name, email, subject and body' do 
    msg = Message.new

    assert msg.respond_to?(:name),    'does not respond to :name'
    assert msg.respond_to?(:email),   'does not respond to :email'
    assert msg.respond_to?(:subject), 'does not respond to :subject'
    assert msg.respond_to?(:body),    'does not respond to :body'
  end

  test 'should be valid when all attributes are set' do
    attrs = { 
      name: 'stephen',
      email: 'stephen@example.org',
      subject: 'loquesea',
      body: 'kthnxbai'
    }

    msg = Message.new attrs
    assert msg.valid?, 'should be valid'
  end

  test 'name, email and body are required by law' do
    msg = Message.new

    refute msg.valid?, 'Blank Mesage should be invalid'

    assert_match /blank/, msg.errors[:name].to_s
    assert_match /blank/, msg.errors[:email].to_s
    assert_match /blank/, msg.errors[:subject].to_s
    assert_match /blank/, msg.errors[:body].to_s
  end
end