class SessionsController < ApplicationController
  skip_before_action :authorize

  def new

  end

  def create
    user = User.find_by(name: params[:name])
    if user and user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url
    else
      flash[:error] = "Invalid user/password combination"
      redirect_to root_url
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to logout_path, notice: "Logged out"
  end

end
