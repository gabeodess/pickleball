class UpdateUserDto
  def self.validate!(params, user)
    dupr_password = params.delete(:dupr_password)

    if dupr_password
      login = Dupr::Authentication.login(email: user.email, password: dupr_password)
      stats = login.dig('user', 'stats')
      params[:dupr_id] = login.dig('user', 'id')
      params[:doubles] = stats['doubles']
      params[:singles] = stats['singles']
    end

    return params
  end
end