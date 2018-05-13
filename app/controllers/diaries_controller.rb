class DiariesController < ApplicationController
  def new
    @diary = Diary.new
    @menu_list = get_menu_list
  end
  
  def create
    @diary = Diary.new(diary_params)
    if !params[:add_menus] && @diary.save
      redirect_to diary_path(@diary.id)
    else
      @menu_list = get_menu_list
      render :new
    end
  end

  def edit
    @diary = Diary.find(params[:id])
    @menu_list = get_menu_list
  end
  
  def update
    @diary = Diary.find(params[:id])
    if @diary.update(diary_params)
      redirect_to diaries_path
    else
      @menu_list = get_menu_list
      render :edit
    end
  end

  def destroy
    @diary = Diary.find(params[:id])
    @diary.destroy
    redirect_to diaries_path
  end
  
  def index
    @diaries = Diary.all
  end

  def show
    @diary = Diary.find(params[:id])
  end
  
private
  def diary_params
    params.require(:diary).permit(
      :date,
      :explain,
      :user_id,
      diary_menus_attributes: [:id, :menu_id, :num, :set, :rest_min, :rest_sec, :_destroy]
    )
  end

  def get_menu_list
    menu_list = Hash.new
    menus = view_context.current_user.following_by_type('Menu')
    menus.each do |menu|
      menu_list[menu.name] = menu.id
    end
    
    menu_list
  end
end
