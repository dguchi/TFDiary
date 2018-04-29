class HomeController < ApplicationController
  before_action :check_root, only: [:top]
  def top
  end

  def tfdiary
  end

  def login_form
    @user = User.new
  end
  
  def login
    @user = User.find_by(mail: params[:user][:mail])
    if @user.authenticate(params[:user][:password])
      view_context.log_in(@user.id)
      redirect_to user_path(@user.id)
    else
      flash[:notice] = "パスワードが違います。"
      render :login_form
    end
  end
  
  def logout
    view_context.log_out
    redirect_to home_login_form_path
  end
  
private
  def check_root
    if view_context.logged_in?
      redirect_to user_path(view_context.current_user.id)
    end
  end
end
