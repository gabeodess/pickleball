require "test_helper"

class Api::Dupr::SessionsControllerTest < ActionDispatch::IntegrationTest
  test "create" do
    user = users(:one)
    sign_in(user)

    stub_request(:post, "https://api.dupr.gg/auth/v1.0/login").to_return(status: 200, body: {
      "result": {
        "refreshToken": "fake-refresh-token",
        "user": {
          "stats": {
            "doubles": "4.0",
            "singles": "3.0"
          },
        }
      }
    }.to_json)

    put('/api/user', params: {user: {duprId: 123}})
    assert_response :ok

    assert_changes "user.doubles", to: 4.0 do
      assert_changes "user.singles", to: 3.0 do
        assert_changes "user.dupr_id", to: 123 do
          user.reload
        end
      end
    end
  end
end
