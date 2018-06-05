class GroupMemberController < ApplicationController
  def top
    @group = Group.find(params[:id])
  end

  def index
    @group = Group.find(params[:group_id])
    @members = @group.user_followers
  end

  def setting
    @group = Group.find(params[:id])
  end
  
  def menu_status
  end
  
  def request_index
  end

  def change_image
    @group = Group.find(params[:id])
    @group.image = params[:group][:image]
    @group.save
    redirect_to top_group_member(@group.id)
  end
  
  def chat_index
    @group = Group.find(params[:id])
    @chats = @group.chats
    @chat = @group.chats.build
  end
  
  def post_chat
    @group = Group.find(params[:id])
    @chat = @group.chats.build(chat_params)
    if @chat.save
      redirect_to chat_index_group_member_path(@group.id)
    else
      render :chat_index
    end
  end
  
  def delete_chat
    @group = Group.find(params[:id])
    @chat = Chat.find(params[:chat_id])
    @chat.destroy
    redirect_to chat_index_group_member_path(@group.id)
  end
  
private
  def chat_params
    params.require(:chat).permit(:user_id, :content)
  end
end
