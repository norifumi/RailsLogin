class SessionsController < ApplicationController
  protect_from_forgery

  def new
    @user = User.new
  end
 
  def create
    @user = User.find_by(email: permtted_params[:email])
    @user = nil unless @user && @user.password == permtted_params[:password]

    respond_to do |format|
      format.html do
        if @user
          session[:signed_in_user] = @user
          return redirect_to :dashboard
        else
          return redirect_to :new_session, flash: {error: "wrong Email or Password"}
        end
      end
      format.json do
        if @user
          render json: {id_access_token: @user.id_access_token}, status: :created
        else
          head :unauthorized
        end
      end
    end
  end

  private

  def permtted_params
    params.require(:user).permit(:email, :password)
  end
end
