class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_destroy_user, only: [:destroy]
  before_action :check_admin_user, only: [:edit, :update, :change_image]
  
  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      user = view_context.current_user
      user.follow(@group)
      user.update(:main_group_id => @group.id)
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
      create_update_notice(@group)
      flash[:notice] = "グループ情報を更新しました"
      redirect_to top_group_member_path(@group.id)
    else
      render :edit
    end
  end

  def show
    @group = Group.find(params[:id])
    @request = GroupRequest.find_by(group_id: @group.id, user_id: view_context.current_user.id)
    if !@request
      @request = @group.group_requests.build
    end
  end
  
  def index
    @group = Search::Group.new
    @groups = Group.page(params[:page]).per(10)
  end

  def destroy
    @group = Group.find(params[:id])
    group_member_unfollow(@group)
    @group.destroy
    redirect_to root_path
  end
  
  def search
    @group = Search::Group.new(search_params)
    @groups =  @group
      .matches
      .order(name: :asc)
      .page(params[:page]).per(20)
    render :index
  end
  
  def change_image
    @group = Group.find(params[:id])
    @group.image = params[:group][:image]
    @group.save
    redirect_to group_path(@group.id)
  end

  def follow
    @group = Group.find(params[:id])
    @request = @group.group_requests.build(group_request_params)
    if @request.save
      redirect_to group_path(@request.group_id)
    else
      render :show
    end
  end
  
  def follow_cancel
    @group = Group.find(params[:id])
    @request = @group.group_requests.find_by(group_request_params)
    @request.destroy
    redirect_to group_path(@group.id)
  end

private
  def group_params
    params.require(:group).permit(:name, :explain, :leader_id)
  end
  
  def group_edit_params
    params.require(:group).permit(:name, :explain, :target)
  end
  
  def group_request_params
    params.require(:group_request).permit(:user_id)
  end
  
  def search_params
    params
      .require(:search_group)
      .permit(Search::Group::ATTRIBUTES)
  end
  
  def group_member_unfollow(group)
    group.user_followers.each do |user|
      user.stop_following(group)
      if user.main_group_id == group.id
        user.update(:main_group_id => nil)
      end
    end
  end
  
  # グループ情報更新通知
  def create_update_notice(group)
    group.user_followers.each do |member|
      notice = member.notices.build()
      notice.create_group_updateinfo(group.name, top_group_member_path(group.id))
      notice.save
    end
  end
  
  # before action
  
  def check_destroy_user
    group = Group.find(params[:id])
    if view_context.current_user.id != group.leader_id
        redirect_to root_path
    end
  end
  
  def check_admin_user
    if !view_context.admin_user?(params[:id], view_context.current_user.id)
      redirect_to root_path(params[:id])
    end
  end
end
