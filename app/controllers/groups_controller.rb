class GroupsController < ApplicationController
  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to group_path(@group.id)
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def show
    @group = Group.find(params[:id])
  end
  
  def index
    @group = Search::Group.new
    @groups = Group.all
  end

  def destroy
  end
  
  def search
    @group = Search::Group.new(search_params)
    @groups =  @group
      .matches
      .order(name: :asc)
    render :index
  end
  
  def change_image
    @group = Group.find(params[:id])
    @group.image = params[:group][:image]
    @group.save
    redirect_to group_path(@group.id)
  end

  def follow
  end
private
  def group_params
    params.require(:group).permit(:name, :explain, :leader_id)
  end
end
