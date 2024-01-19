class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token
  rescue_from ActionController::ParameterMissing, with: :handle_400

  def handle_400(e)
    render json: {error: e.message}, status: 400
  end
end
