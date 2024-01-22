require "application_system_test_case"

class InvitationsTest < ApplicationSystemTestCase
  def setup
    @user = users(:one)
    @group = groups(:one)
  end

  test "visiting the index" do
    visit root_path
    fill_in "Email", with: @user.email
    fill_in "Password", with: :password
    click_on 'Sign In'
    click_on @group.name
    click_on @group.name
    fill_in 'email', with: '444-444-4444'
    assert_difference "Invitation.count" do
      click_on "Add Member"
      assert_text "Pending"
    end
  end
end
