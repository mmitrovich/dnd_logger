class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

    before_action :confirm_logged_in,
    :except => [:login, :attempt_login, :logout]


   private

  def confirm_logged_in
    unless session[:user_id]
      flash[:notice] = "Please login."
      redirect_to access_login_path
    end
  end 
end
