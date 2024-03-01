class Api::UsersController < ApiController
  def show
    render json: User.accessible_by(current_user).find(params[:id]).as_json(:v1)
  end

  def update
    dto = UpdateUserDto.validate!(params.require(:user).permit(:dupr_password), current_user)
    current_user.update!(dto)
    render json: current_user.as_json(:v1), status: :ok
  rescue Dupr::Errors::Base => e
    render json: {error: e.message}, status: 400
  end
end
