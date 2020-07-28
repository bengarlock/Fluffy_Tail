class SessionsController < ApplicationController
    skip_before_action :authorized, only: [:new, :login]

    def new 
        render :login
    end 
  
    def login
      user = User.find_by(name: params[:session][:name])
  
      if user && user.authenticate(params[:session][:password])
        session[:user_id] = user.id 
        redirect_to users_path
      else 
        flash[:error] = "Username or Password is incorrect"
        redirect_to new_session_path
      end
    end 
    
    def logout 
      session.delete(:user_id)
      redirect_to new_user_path
    end

end