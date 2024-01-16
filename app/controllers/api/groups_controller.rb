class Api::GroupsController < ApiController
  def show
    render json: current_user.groups.find(params[:id])
  end

  def create
    group = current_user.owned_groups.build(params.require(:group).permit(:name))
    group.users << current_user
    if group.save
      head :created
    else
      render json: {errors: group.errors}, status: :unprocessable_entity
    end
  end

  def index
    render json: {items: current_user.groups}
  end
end
