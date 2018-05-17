class DiariesController < ApplicationController
  before_action :check_login

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
    redirect_to diaries_path
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

private
  def diary_params
    params.require(:diary).permit(
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
end
