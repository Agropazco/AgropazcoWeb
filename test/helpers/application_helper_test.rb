require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    assert_equal full_title, "Agropazco"
    assert_equal full_title("Ayuda"), "Ayuda | Agropazco"
  end
end

