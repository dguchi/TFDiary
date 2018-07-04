class GroupDiariesController < DiariesController
  before_action :authenticate_user!
  before_action :check_group_member

  def new
    @group = Group.find(params[:group_id])
    @diary = @group.diaries.build
    @menu_list = get_menu_list(view_context.current_user)
  end

  def create
    @group = Group.find(params[:group_id])
    @diary = @group.diaries.build(diary_params)
    if @diary.save
      create_menu_notice(@group, @diary.id)
      redirect_to group_group_diary_path(:group_id => @group.id, :id => @diary.id)
    else
      render :new
    end
  end

  def edit
    @group = Group.find(params[:group_id])
    @diary = Diary.find(params[:id])
    @menu_list = get_menu_list(view_context.current_user)
  end

  def update
    @group = Group.find(params[:group_id])
    @diary = Diary.find(params[:id])
    if @diary.update(diary_params)
      redirect_to group_group_diary_path(:group_id => @group.id, :id => @diary.id)
    else
      @menu_list = get_menu_list(view_context.current_user)
      render :edit
    end
  end

  def show
    @group = Group.find(params[:group_id])
    @diary = Diary.find(params[:id])
  end

  def destroy
    @diary = Diary.find(params[:id])
    @group = Group.find(params[:group_id])
    @diary.destroy
    redirect_to group_group_diaries_path(@group.id)
  end
  
  def index
    @group = Group.find(params[:group_id])
  end

  def add_all_menu
    @group = Group.find(params[:group_id])
    @user = view_context.current_user
    @diary = @group.diaries.build(diary_params)
    @menus_run = @user.following_menus.where(:kind => Menu.kinds[:run])
    @menus_jump = @user.following_menus.where(:kind => Menu.kinds[:jump])
    @menus_throw = @user.following_menus.where(:kind => Menu.kinds[:throw])
    @menus_drill = @user.following_menus.where(:kind => Menu.kinds[:drill])
    @menus_other = @user.following_menus.where(:kind => Menu.kinds[:other])
  end

  def regist_menus
    @group = Group.find(params[:group_id])
    @user = view_context.current_user
    @diary = @group.diaries.build(diary_params)
    get_check_menu(@user, @diary)
    @menu_list = get_menu_list(@user)
    render :new
  end

private
  def check_group_member
    if !view_context.current_user.following?(Group.find(params[:group_id]))
      redirect_to root_path
    end
  end

  # グループメニュー配信通知
  def create_menu_notice(group, diary_id)
    group.user_followers.each do |member|
      notice = member.notices.build()
      notice.create_group_diary(group, group_group_diary_path(group.id, diary_id))
      notice.save
    end
  end
end
