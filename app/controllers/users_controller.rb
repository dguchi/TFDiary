class UsersController < ApplicationController
  before_action :check_login, except: [:new, :create]
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(users_params)
    
    if @user.save
      view_context.log_in(@user.id)
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def show
  end

  def destroy
  end

  def follow_index
  end

  def menu_index
  end

  def group_index
  end
  
private
  def users_params
    params.require(:user).permit(:name, :mail, :password, :password_confirmation, :main_group_id, :image)
  end
  
end
