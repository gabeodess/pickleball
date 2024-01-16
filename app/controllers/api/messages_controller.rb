class Api::MessagesController < ApiController
  def index
    render json: {items: group.messages.as_json(:v1)}
  end

  def create
    message = group.messages.build(params.require(:message).permit(:body))
    message.user = current_user
    if message.save
      head :created
    else
      render json: {errors: message.errors}, status: :unprocessable_entity
    end
  end

  private

  def group
    @group ||= current_user.groups.find(params[:group_id])
  end
end
