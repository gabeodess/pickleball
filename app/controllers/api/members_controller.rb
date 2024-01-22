class Api::MembersController < ApiController
  def index
    render json: {items: group.members.includes(:user).as_json(:v1)}
  end

  def create
    @user = User.find_by_email_or_phone(params.require(:email_or_phone))
    @user ? create_member : create_invitation
  end

  private

  def create_invitation
    invitation = group.invitations.build(inviter: current_user, email_or_phone: params[:email_or_phone])
    if invitation.save
      head :created
    else
      render json: {errors: invitation.errors}, status: :unprocessable_entity
    end
  end

  def create_member
    member = group.members.build(user: @user)
    if member.save
      head :created
    else
      render json: {errors: member.errors}, status: :unprocessable_entity
    end
  end

  def group
    @group ||= current_user.groups.find(params[:group_id])
  end
end
