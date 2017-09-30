class GroupsController < ApplicationController

  def create
    puts params
    group = Group.new(group_params)
    if group.save
      render json: group
    else
      render json: {errors: group.errors.full_messages}
    end
  end

  def show
    group = Group.find_by(id: params[:id])
    if group
      render json: group
    else
      render json: {error: "Group does not exist, please try again"}
    end
  end

  def settle
    group = Group.find_by(id: params[:id])
    group.settled_up = "true"
    if group.settled_up == true
      render json: {message: "The group was successfully settled!"}
    else
      render json: {message: "Something went wrong, the group was not settled."}
    end
  end

  private
  def group_params
    params.require(:group).permit(:group_name, :details, :creator_id, :settled_up)
  end
end