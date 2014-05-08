class SessionsController < ApplicationController
  skip_before_action :authorize

  def new

  end

  def create
    user = User.find_by(name: params[:name])
    if user and user.authenticate(params[:password])
      puts user.id
      session[:user_id] = user.id
      puts "SESSION CREATE" + session[:user_id].to_s
      redirect_to root_url
    else
      redirect_to root_url, alert: "Invalid user/password combination"
    end
  end

  def destroy
    session[:user_id] = nil
    puts "SESSION DESTROY" + session[:user_id].to_s

    redirect_to logout_path, notice: "Logged out"
  end

end
