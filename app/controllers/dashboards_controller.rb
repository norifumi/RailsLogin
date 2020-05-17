class DashboardsController < ApplicationController
  before_action :authorize_user!
 
  def show
    respond_to do |format|
      format.html do
        @user = current_user
      end
      format.json do
        render json: {name: current_user.name}
      end
    end
  end
 
  private
 
  def authorize_user!
    return true if current_user
    redirect_to :new_session, flash: {error: "signing in required"}
  end

  def current_user
    return @current_user if @current_user
    return @current_user = session[:signed_in_user] if session[:signed_in_user]
    @current_user = User.find_by_id_access_token request.headers["HTTP_ID_ACCESS_TOKEN"] if request.headers["HTTP_ID_ACCESS_TOKEN"]
  end

end
