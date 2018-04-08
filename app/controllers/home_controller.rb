class HomeController < ApplicationController
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
      render login_form
    end
  end
  
  def logout
    view_context.log_out
    redirect_to home_login_form_path
  end
end
