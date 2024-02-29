class Dupr::AuthenticateJob < ApplicationJob
  queue_as :default

  def perform(email:, password:)
    response = Net::HTTP.post(
      URI('https://api.dupr.gg/auth/v1.0/login'), 
      {
        email: email,
        password: password
      }.to_json, 
      {
        "Content-Type" => "application/json"
      }
    )
    result = JSON.load(response.body)["result"]
    stats = result.dig("user", "stats")
    User.find_by_email(email).update!({
      doubles: stats["doubles"],
      singles: stats["singles"],
      dupr_refresh_token: result['refreshToken']
    })
  end
end
