class AccessController < ApplicationController
	  def login
	  	# login form
	  end


	  def attempt_login
	  	if params[:user_name].present? && params[:password].present?
	  		found_user = AdminUser.where(:user_name => params[:user_name]).first
	  		if found_user
	  			authorized_user = found_user.authenticate(params[:password])
	  		end
	  	end

	  	if authorized_user
	  		session[:user_id] = authorized_user.id
	  		flash[:notice] = "Logged in successfully."
	  		redirect_to root_path
	  	else
	  		flash.now[:notice] = "Invalid login credentials!"
	  		render 'login'
	  	end
	  end

	  def logout
	  	session[:user_id] = nil
	  	flash[:notice] = "Logged out."
	  	redirect_to access_login_path
	  end
end
