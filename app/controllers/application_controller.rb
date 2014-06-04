class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  before_action :authorize

  protected

  def authorize
    unless User.find_by(id: session[:user_id])
      redirect_to root_path, notice: "please log in"
    end
  end

  def authorize_admin
    unless (User.find_by(id: session[:user_id]) && (User.find_by(id: session[:user_id]).isAdmin ==false))
      redirect_to root_path, notice: "please log in"
    end
  end

end

