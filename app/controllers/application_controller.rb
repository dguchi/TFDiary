class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def check_login
    if !(view_context.logged_in?)
      redirect_to home_login_form_path
    end
  end
end
