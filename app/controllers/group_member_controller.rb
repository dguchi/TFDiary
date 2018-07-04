class GroupMemberController < ApplicationController
  before_action :authenticate_user!
  before_action :check_group_member, except: [:index]
  before_action :check_group_member_index, only: [:index]
  before_action :check_admin_user, only: [:setting, :request_index, :assign_job, :change_job]
  
  def top
    @group = Group.find(params[:id])
    @chats = @group.chats.order(created_at: :desc).page(params[:page]).per(20)
    @chat = @group.chats.build
  end

  def index
    @group = Group.find(params[:group_id])
    @members = @group.user_followers.page(params[:page]).per(20)
  end

  def menu_status
    # メニュー達成率の機能追加予定
    @group = Group.find(params[:id])
  end
  
  def change_image
    @group = Group.find(params[:id])
    @group.image = params[:group][:image]
    @group.save
    redirect_to top_group_member(@group.id)
  end
  
  def post_chat
    @group = Group.find(params[:id])
    @chat = @group.chats.build(chat_params)
    if @chat.save
      create_chat_notice(@group)
      redirect_to top_group_member_path(@group.id)
    else
      render :top
    end
  end
  
  def delete_chat
    @group = Group.find(params[:id])
    @chat = Chat.find(params[:chat_id])
    @chat.destroy
    redirect_to top_group_member_path(@group.id)
  end
  
  def setting
    @group = Group.find(params[:id])
  end
  
  def request_index
    @group = Group.find(params[:id])
    @requests = @group.group_requests.page(params[:page]).per(20)
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
    create_addmember_notice(group, user)
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
  
  def unfollow_confirm
    @group = Group.find(params[:id])
  end

  def unfollow
    group = Group.find(params[:id])
    view_context.current_user.stop_following(group)
    redirect_to group_index_user_path(view_context.current_user.id)
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
  
  # メンバ追加通知
  def create_addmember_notice(group, user)
    group.user_followers.each do |member|
      notice = member.notices.build()
      notice.create_group_addmember(group, user.name, group_group_member_index_path(group.id))
      notice.save
    end
  end

  # チャット投稿通知
  def create_chat_notice(group)
    group.user_followers.each do |member|
      latest = member.notices.order(created_at: :desc).first
      notice = member.notices.build()
      notice.create_group_chat(group, top_group_member_path(group.id))
      unless latest.msg == notice.msg
        notice.save
      end
    end
  end
end
