class Api::Dupr::SessionsController < ApiController
  def create
    Dupr::AuthenticateJob.perform_now(email: current_user.email, password: params[:password])
    head :created
  end
end
