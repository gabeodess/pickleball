require "test_helper"

class Dupr::AuthenticateJobTest < ActiveJob::TestCase
  test "#perform" do
    user = users(:one)

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
    }.to_json
  )

    assert_changes "user.doubles", to: 4.0 do
      assert_changes "user.singles", to: 3.0 do
        assert_changes "user.dupr_refresh_token", to: 'fake-refresh-token' do
          Dupr::AuthenticateJob.perform_now(email: user.email, password: 'foobar')
          user.reload
        end
      end
    end
  end
end
