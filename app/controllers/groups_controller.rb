class GroupsController < ApplicationController
  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      view_context.current_user.follow(@group)
      redirect_to group_path(@group.id)
    else
      render :new
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_edit_params)
      redirect_to top_group_member_path(@group.id)
    else
      render :edit
    end
  end

  def show
    @group = Group.find(params[:id])
    @request = GroupRequest.find_by(group_id: @group.id, user_id: view_context.current_user.id)
    if !@request
      @request = GroupRequest.new
    end
  end
  
  def index
    @group = Search::Group.new
    @groups = Group.all
  end

  def destroy
  end
  
  def search
    @group = Search::Group.new(search_params)
    @groups =  @group
      .matches
      .order(name: :asc)
    render :index
  end
  
  def change_image
    @group = Group.find(params[:id])
    @group.image = params[:group][:image]
    @group.save
    redirect_to group_path(@group.id)
  end

  def follow
    @request = GroupRequest.new(group_request_params)
    if @request.save
      redirect_to group_path(@request.group_id)
    else
      render :show
    end
  end
  
  def follow_cancel
    @request = GroupRequest.find_by(group_request_params)
    group_id = @request.group_id
    @request.destroy
    redirect_to group_path(group_id)
  end
  
  def follow_approve
  end
private
  def group_params
    params.require(:group).permit(:name, :explain, :leader_id)
  end
  
  def group_edit_params
    params.require(:group).permit(:name, :explain, :target)
  end
  
  def group_request_params
    params.require(:group_request).permit(:user_id, :group_id)
  end
end
