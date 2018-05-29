class GroupMemberController < ApplicationController
  def top
    @group = Group.find(params[:id])
  end

  def index
    @group = Group.find(params[:group_id])
    @members = @group.user_followers
  end

  def menu_confirm
  end

  def menu_status
  end
  
  def setting
    @group = Group.find(params[:id])
  end
  
  def request_index
  end

  def change_image
    @group = Group.find(params[:id])
    @group.image = params[:group][:image]
    @group.save
    redirect_to top_group_member(@group.id)
  end
end
