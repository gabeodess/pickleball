require "application_system_test_case"

class GroupsTest < ApplicationSystemTestCase
  def setup
    @user = users(:one)
    @user2 = users(:two)
  end

  test "groups" do
    visit root_path
    fill_in "Email", with: @user.email
    fill_in "Password", with: :password
    click_on 'Sign In'
    fill_in "Group name", with: 'foobar'
    assert_difference 'Group.count' do
      click_on 'Add Group'
      assert_text :foobar
    end
    click_on :foobar
    click_on :Send
    assert_selector ".is-invalid"
    fill_in 'message[body]', with: "hello world"
    assert_difference "Message.count" do
      click_on :Send
      assert_text "hello world"  
    end
    assert_no_selector ".is-invalid"
  end
end
