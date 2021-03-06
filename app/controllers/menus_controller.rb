class MenusController < ApplicationController
  before_action :authenticate_user!, :only => [:new, :create, :edit, :update, :destroy]
  before_action :check_auther_action, :only => [:update, :destroy]

  def new
    @menu = Menu.new
  end
  
  def create
    @menu = Menu.new(menu_params)
    @menu.author_id = view_context.current_user.id
    if @menu.save
      view_context.current_user.follow(@menu)
      redirect_to menu_path(@menu.id)
    else
      render :new
    end
  end
  
  def edit
    @menu = Menu.find(params[:id])
  end

  def update
    @menu = Menu.find(params[:id])
    @menu.update(menu_params)
    redirect_to menu_path(@menu.id)
  end
  
  def index
    @menu = Search::Menu.new
    @menus = Menu.where(:secret => Menu.secrets[:pub]).order(created_at: :desc).page(params[:page]).per(20)
  end
  
  def destroy
    @menu = Menu.find(params[:id])
    @menu.update(:secret => Menu.secrets[:pri])
    view_context.current_user.stop_following(@menu)
    redirect_to menus_path
  end
  
  def show
    @menu = Menu.find(params[:id])
    @author = User.find_by(id: @menu.author_id)
  end
  
  def register_index
    @menu = Menu.find(params[:id])
    @registers = @menu.user_followers.page(params[:page]).per(20)
  end
  
  def search
    @menu = Search::Menu.new(search_params)
    @menus =  @menu
      .matches
      .where(:secret => false)
      .order(name: :asc)
      .page(params[:page]).per(20)
    render :index
  end

private
  def menu_params
    params.require(:menu).permit(:name, :kind, :explain)
  end
  
  def search_params
    params
      .require(:search_menu)
      .permit(Search::Menu::ATTRIBUTES)
  end
  
  def check_auther_action
    menu = Menu.find(params[:id])
    unless menu.author_id == view_context.current_user.id
      redirect_to menu_path(menu.id)
    end
  end
end
