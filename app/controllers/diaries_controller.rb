class DiariesController < ApplicationController
  before_action :authenticate_user!

  def new
    @user = User.find(params[:user_id])
    @diary = @user.diaries.build
    @menu_list = get_menu_list(@user)
  end
  
  def create
    @user = User.find(params[:user_id])
    @diary = @user.diaries.build(diary_params)
    if @diary.save
      redirect_to diary_path(@diary.id)
    else
      @menu_list = get_menu_list(@user)
      render :new
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
    if @diary.update(diary_params)
      redirect_to user_diaries_path(@user.id)
    else
      @menu_list = get_menu_list(@user)
      render :edit
    end
  end

  def destroy
    @diary = Diary.find(params[:id])
    @diary.destroy
    redirect_to user_diaries_path(@diary.user_id)
  end
  
  def index
    @user = User.find(params[:user_id])
    @diaries = @user.diaries
  end

  def show
    @diary = Diary.find(params[:id])
    @comments = @diary.comments
    @comment = Comment.new
  end
  
  def add_all_menu
    @user = User.find(params[:user_id])
    @diary = @user.diaries.build(diary_params)
    @menus_run = @user.following_menus.where(:kind => Menu.kinds[:run])
    @menus_jump = @user.following_menus.where(:kind => Menu.kinds[:jump])
    @menus_throw = @user.following_menus.where(:kind => Menu.kinds[:throw])
    @menus_drill = @user.following_menus.where(:kind => Menu.kinds[:drill])
    @menus_other = @user.following_menus.where(:kind => Menu.kinds[:other])
  end
  
  def regist_menus
    @user = User.find(params[:user_id])
    @diary = @user.diaries.build(diary_params)
    get_check_menu(@user, @diary)
    @menu_list = get_menu_list(@user)
    render :new
  end

  def select_group_menu
    @user = User.find(params[:user_id])
    @group = Group.find(@user.main_group_id)
  end

  def read_group_menu
    @user = User.find(params[:user_id])
    @diary = @user.diaries.build
    @menu_list = get_menu_list(@user)
    diary_menu_copy(@diary, @menu_list)
    render :new
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
  
  def get_menu_list(user)
    menu_list = Hash.new
    menus = user.following_by_type('Menu')
    menus.each do |menu|
      menu_list[menu.name] = menu.id
    end
    
    menu_list
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
end
