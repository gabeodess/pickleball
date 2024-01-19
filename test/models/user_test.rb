require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "initialize user" do
    user = User.create!(email: 'foobar@example.com', password: 'password')
  end
end
