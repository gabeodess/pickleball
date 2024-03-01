class Dupr::Authentication
  def self.login(email:, password:)
    response =  Net::HTTP.post(
      URI('https://api.dupr.gg/auth/v1.0/login'), 
      {
        email: email,
        password: password
      }.to_json, 
      {
        "Content-Type" => "application/json"
      }
    )
    return JSON.load(response.body)["result"] if response.code === '200'
    raise Dupr::Errors::Forbidden.new("Invalid password")
  end
end