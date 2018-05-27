class GroupMemberController < ApplicationController
  def top
    @group = Group.find(params[:id])
  end

  def index
    @group = Group.find(params[:id])
  end

  def menu_confirm
  end

  def setting
  end
end
