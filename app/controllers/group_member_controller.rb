class GroupMemberController < ApplicationController
  before_action :authenticate_user!
  before_action :check_group_member, except: [:index]
  before_action :check_group_member_index, only: [:index]
  before_action :check_admin_user, only: [:setting, :request_index, :assign_job, :change_job]
  
  def top
    @group = Group.find(params[:id])
    @diaries = @group.diaries.where(:date => Time.now.strftime("%Y-%m-%d"))
  end

  def index
    @group = Group.find(params[:group_id])
    @members = @group.user_followers
  end

  def menu_status
    # メニュー達成率の機能追加予定
  end
  
  def change_image
    @group = Group.find(params[:id])
    @group.image = params[:group][:image]
    @group.save
    redirect_to top_group_member(@group.id)
  end
  
  def chat_index
    @group = Group.find(params[:id])
    @chats = @group.chats
    @chat = @group.chats.build
  end
  
  def post_chat
    @group = Group.find(params[:id])
    @chat = @group.chats.build(chat_params)
    if @chat.save
      redirect_to chat_index_group_member_path(@group.id)
    else
      render :chat_index
    end
  end
  
  def delete_chat
    @group = Group.find(params[:id])
    @chat = Chat.find(params[:chat_id])
    @chat.destroy
    redirect_to chat_index_group_member_path(@group.id)
  end
  
  def setting
    @group = Group.find(params[:id])
  end
  
  def request_index
    @group = Group.find(params[:id])
    @requests = @group.group_requests
  end

  def assign_job
    @group = Group.find(params[:id])
    @members = @group.user_followers
  end
  
  def change_job
    @group = Group.find(params[:id])
    @group.update(change_job_params)
    redirect_to assign_job_group_member_path(@group.id)
  end
  
  def follow_approve
    group = Group.find(params[:id])
    user = User.find(params[:user_id])
    user.follow(group)
    group.group_requests.find_by(user_id: user.id).destroy
    redirect_to request_index_group_member_path(group.id)
  end

  def follow_reject
    group = Group.find(params[:id])
    user = User.find(params[:user_id])
    group.group_requests.find_by(user_id: user.id).destroy
    redirect_to request_index_group_member_path(group.id)
  end

private
  def chat_params
    params.require(:chat).permit(:user_id, :content)
  end
  
  def check_group_member
    if !view_context.current_user.following?(Group.find(params[:id]))
      redirect_to root_path
    end
  end

  def check_group_member_index
    if !view_context.current_user.following?(Group.find(params[:group_id]))
      redirect_to root_path
    end
  end

  def check_admin_user
    if !view_context.admin_user?(params[:id], view_context.current_user.id)
      redirect_to top_group_member_path(params[:id])
    end
  end
  
  def change_job_params
    params.require(:group).permit(:leader_id, :subleader_id1, :subleader_id2, :subleader_id3, :manager_id1, :manager_id2)
  end
end
