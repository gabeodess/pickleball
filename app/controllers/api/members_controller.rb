class Api::MembersController < ApiController
  def index
    render json: {items: group.members.includes(:user).as_json(:v1)}
  end

  def create
    member = group.members.build(user: User.find_by_email(params.require(:email)))
    if member.save
      head :created
    else
      render json: {errors: member.errors}, status: :unprocessable_entity
    end
  end

  private

  def group
    @group ||= current_user.groups.find(params[:group_id])
  end
end
