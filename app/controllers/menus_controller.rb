class MenusController < ApplicationController
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
    @menus = Menu.all.order(created_at: :asc)
  end
  
  def destroy
  end
  
  def show
    @menu = Menu.find(params[:id])
  end
  
  def search
    @menu = Search::Menu.new(search_params)
    @menus =  @menu
      .matches
      .order(name: :asc)
    render :index
  end
private
  def menu_params
    params.require(:menu).permit(:name, :kind, :explain, :secret)
  end
  
  def search_params
    params
      .require(:search_menu)
      .permit(Search::Menu::ATTRIBUTES)
  end
end
