class DiariesController < ApplicationController
  def new
    @diary = Diary.new
    @diary.diary_menus.build
    get_new_paramater
  end
  
  def create
    @diary = Diary.new(diary_params)
    if !params[:add_menus] && @diary.save
      redirect_to diary_path(@diary.id)
    else
      get_new_paramater
      render :new
    end
  end

  def edit
  end
  
  def update
  end

  def index
    @diaries = Diary.all
  end

  def show
  end
  
  def add_menus
    @diary = Diary.new(diary_params_no_fields)
    @diary.diary_menus.build
    get_new_paramater
    render :new
  end
  
private
  def diary_params
    params.require(:diary).permit(
      :date,
      :explain,
      :user_id,
      diary_menus_attributes: [:menu_id, :num, :set, :rest_min, :rest_sec]
    )
  end

  def diary_params_no_fields
    params.require(:diary).permit(
      :date,
      :explain,
    )
  end
  
  def get_new_paramater
    @menus = view_context.current_user.following_by_type('Menu')
    @add_menus = get_add_menus
    @check_menuid_list = get_check_menu_list(@menus, @add_menus)
  end
  
  def get_create_paramater
    @menus = view_context.current_user.following_by_type('Menu')
    @add_menus = []
    @check_menuid_list = get_check_menu_list(@menus, @add_menus)
  end
  
  def get_add_menus
    add_menus = Array.new
    logger.debug("*****#{params}*****")

    if params[:menu_num]
      menu_num = params[:menu_num]
      menu_num.to_i.times do |number|
        key = get_check_menu_key(number)
        if params[key]
          logger.debug("*****#{params[key]}*****")
          add_menus << Menu.find(params[key])
        end
      end
    end
    
    add_menus
  end
  
  def get_check_menu_key(number)
    "add_menu_" + number.to_s
  end
  
  def get_check_menu_list(reg_menus, add_menus)
    retlist = Array.new
    reg_menus.each do |regmenu|
      if add_menus.index(regmenu)
        retlist << true
      else
        retlist << false
      end
    end
    
    retlist
  end
end
