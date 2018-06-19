class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @user = User.find(params[:id])
    if @user.main_group_id
      group = Group.find(@user.main_group_id)
      @diaries = group.diaries.where(:date => Time.now.strftime("%Y-%m-%d"))
    else
      @diaries = @user.diaries.where(:date => Time.now.strftime("%Y-%m-%d"))
    end
  end

  def follow_index
    @user = User.find(params[:id])
    @follows = @user.following_users
  end

  def follower_index
    @user = User.find(params[:id])
    @followers = @user.user_followers
  end
  
  def menu_index
    @user = User.find(params[:id])
    @menus = @user.following_menus
    @menus_run = @menus.where(:kind => Menu.kinds[:run])
    @menus_jump = @menus.where(:kind => Menu.kinds[:jump])
    @menus_throw = @menus.where(:kind => Menu.kinds[:throw])
    @menus_drill = @menus.where(:kind => Menu.kinds[:drill])
    @menus_other = @menus.where(:kind => Menu.kinds[:other])
  end

  def group_index
    @user = User.find(params[:id])
    @groups = @user.following_groups
  end
  
  def change_image
    @user = User.find(view_context.current_user.id)
    @user.image = params[:user][:image]
    @user.save
    redirect_to user_path(@user.id)
  end
  
  def follow_menu
    menu = Menu.find(params[:menu_id])
    view_context.current_user.follow(menu)
    render :nothing => true
  end
  
  def unfollow_menu
    menu = Menu.find(params[:menu_id])
    view_context.current_user.stop_following(menu)
    render :nothing => true
  end

  def follow_user
    user = User.find(params[:user_id])
    view_context.current_user.follow(user)
    create_follow_notice(view_context.current_user, user)
    render :nothing => true
  end
  
  def unfollow_user
    user = User.find(params[:user_id])
    view_context.current_user.stop_following(user)
    render :nothing => true
  end
  
  def follow_diary
    diary = Diary.find(params[:diary_id])
    view_context.current_user.follow(diary)
    create_follow_notice(view_context.current_user, diary)
    render :nothing => true
  end
  
  def unfollow_diary
    logger.debug("********unfollow_diary(#{params[:diary_id]})*********")
    diary = Diary.find(params[:diary_id])
    view_context.current_user.stop_following(diary)
    render :nothing => true
  end
  
  def set_main_group
    user = User.find(params[:id])
    user.update(:main_group_id => params[:group_id])
    redirect_to group_index_user_path(user.id)
  end
  
  def unregist_confirm
  end
  
  def unregist
    user = view_context.current_user
    if user.valid_password?(params[:password])
      # グループリーダーでない場合のみ退会可能
      if !view_context.group_leader?(user.id)
        user.soft_delete
        sign_out(user)
        redirect_to root_path
      else
        flash[:alert] = "所属しているグループのリーダーとなっています"
        redirect_to unregist_confirm_users_path
      end
    end
  end
  
private
  # フォロー時の通知
  def create_follow_notice(user, follow)
    notice = follow.notices.build()
    notice.create_user_favorite(user.name, user_path(user.id))
    notice.save
  end
  
  # 日誌いいね時の通知
  def create_diary_notice(user, diary)
    notice = User.find(diary.user_id).notices.build()
    notice.create_diary_favorite(user.name, diary_path(diary_id))
    notice.save
  end
end
