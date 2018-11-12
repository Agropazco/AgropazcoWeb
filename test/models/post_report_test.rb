require 'test_helper'

class PostReportTest < ActiveSupport::TestCase
  def setup
    @post_report = post_reports(:ronaldo_report_juanValdez)
  end

  test "should be valid" do
    assert @post_report.valid?
  end

  test "reporting user should not be post creator" do
  	@post_report.user_id=@post_report.post.user_id
  	assert_not @post_report.valid?
  end

  test "user should be present" do
  	@post_report.user_id=nil
  	assert_not @post_report.valid?
  end

  test "post should be present" do
  	@post_report.post_id=nil
  	assert_not @post_report.valid?
  end

  test "message should not be blank" do
  	for m in blanks do
  		@post_report.message=m
  		assert_not @post_report.valid?
  	end
  end

  test "topic should not be blank" do
  	for m in blanks do
  		@post_report.topic=m
  		assert_not @post_report.valid?
  	end
  end

end
