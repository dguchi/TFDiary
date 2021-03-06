class DiariesController < ApplicationController
  before_action :authenticate_user!
  before_action :delete_tmp, except: [:add_all_menu, :regist_menus, :select_group_menu, :read_group_menu]

  def new
    @user = User.find(params[:user_id])
    @diary = @user.diaries.build
    @menu_list = get_menu_list(@user)
  end
  
  def create
    @user = User.find(params[:user_id])
    if view_context.current_user.id == @user.id
      @diary = @user.diaries.build(diary_params)
      if @diary.save
        create_notice(@user, @diary.id)
        redirect_to diary_path(@diary.id)
      else
        @menu_list = get_menu_list(@user)
        render :new
      end
    else
      redirect_to user_path(@user.id)
    end
  end

  def edit
    @diary = Diary.find(params[:id])
    @user = User.find(@diary.user_id)
    @menu_list = get_menu_list(@user)
  end
  
  def update
    @diary = Diary.find(params[:id])
    @user = User.find(@diary.user_id)
    if @diary.user_id == @user.id
      if @diary.update(diary_params)
        redirect_to user_diaries_path(@user.id)
      else
        @menu_list = get_menu_list(@user)
        render :edit
      end
    else
      redirect_to user_diaries_path(@user.id)
    end
  end

  def destroy
    @diary = Diary.find(params[:id])
    if view_context.current_user.id == @diary.user_id
      @diary.destroy
    end
    redirect_to user_diaries_path(@diary.user_id)
  end
  
  def index
    @user = User.find(params[:user_id])
  end

  def show
    @diary = Diary.find(params[:id])
    @comments = @diary.comments
    @comment = Comment.new
  end
  
  def save_diary_all
    @user = User.find(params[:user_id])
    set_diary_temp(@user)
    redirect_to add_all_menu_user_diaries_path(@user.id)
  end

  def add_all_menu
    @user = User.find(params[:user_id])
    @menus_run = @user.following_menus.where(:kind => Menu.kinds[:run])
    @menus_jump = @user.following_menus.where(:kind => Menu.kinds[:jump])
    @menus_throw = @user.following_menus.where(:kind => Menu.kinds[:throw])
    @menus_drill = @user.following_menus.where(:kind => Menu.kinds[:drill])
    @menus_other = @user.following_menus.where(:kind => Menu.kinds[:other])
  end
  
  def regist_menus
    @user = User.find(params[:user_id])
    @diary = @user.diaries.find_by(temp: true)
    get_check_menu(@user, @diary)
    @menu_list = get_menu_list(@user)
    render :new
  end

  def save_diary_group
    @user = User.find(params[:user_id])
    set_diary_temp(@user)
    redirect_to select_group_menu_user_diaries_path(@user.id)
  end

  def select_group_menu
    @user = User.find(params[:user_id])
    unless @user.main_group_id.nil?
      @group = Group.find(@user.main_group_id)
    else
      flash[:alert] = "メイングループが設定されていません"
      @diary = @user.diaries.find_by(temp: true)
      @menu_list = get_menu_list(@user)
      render :new
    end
  end

  def read_group_menu
    @user = User.find(params[:user_id])
    @diary = @user.diaries.find_by(temp: true)
    @menu_list = get_menu_list(@user)
    diary_menu_copy(@diary, @menu_list)
    render :new
  end

  def favoriter_index
    @diary = Diary.find(params[:id])
    @favoriters = @diary.user_followers.page(params[:page]).per(20)
  end
  
private
  def diary_params
    params.require(:diary).permit(
      :title,
      :date,
      :explain,
      diary_menus_attributes: [:id, :menu_id, :num, :set, :rest_min, :rest_sec, :_destroy]
    )
  end

  def delete_tmp
    tmp = view_context.current_user.diaries.find_by(temp: true)
    unless tmp.nil?
      tmp.destroy
    end
  end

  def get_menu_list(user)
    menu_list = Hash.new
    menus = user.following_by_type('Menu')
    menus.each do |menu|
      menu_list[menu.name] = menu.id
    end
    
    return menu_list
  end
  
  def get_check_menu(user, diary)
    menus = user.following_by_type('Menu')
    menus.each do |menu|
      if params[:menu]["#{menu.id}"]
        diary.diary_menus.build(:menu_id => menu.id,
                                :num => 0,
                                :set => 0,
                                :rest_min => 0,
                                :rest_sec => 0)
      end
    end
  end
  
  def diary_menu_copy(diary, menu_list)
    diary_org = Diary.find(params[:diary_id])
    diary_org.diary_menus.each do |diary_menu|
      diary.diary_menus.build(:menu_id => diary_menu.menu_id,
                              :num => diary_menu.num,
                              :set => diary_menu.set,
                              :rest_min => diary_menu.rest_min,
                              :rest_sec => diary_menu.rest_sec)
      
      menu = Menu.find(diary_menu.menu_id)
      if !menu_list.has_key?(menu.name)
        menu_list[menu.name] = menu.id
      end
    end
  end

  def set_diary_temp(user)
    diary_temp = user.diaries.build(diary_params)
    diary_temp.temp = true
    diary_temp.save
  end

  # フォロワーへ日誌生成通知
  def create_notice(user, diary_id)
    user.user_followers.each do |follower|
      latest = follower.notices.order(created_at: :desc).first
      notice = follower.notices.build()
      notice.create_user_diary(user, diary_path(diary_id))
      unless latest&.msg == notice.msg
        notice.save
      end
    end
  end
end
