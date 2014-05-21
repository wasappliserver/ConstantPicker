class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
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

  def start_jenkins
    respond_to do |format|
      format.html
      format.text
    end
  end


end

